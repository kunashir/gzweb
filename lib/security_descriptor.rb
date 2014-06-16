require 'byte_strings'
require 'security_identifier'
require 'base64'

module SDDL
  class SecurityDescriptor
    attr_accessor :owner, :flags, :group, :resource_manager_data, :sacl, :dacl

    def initialize
      self.flags = 0x8000
      self.resource_manager_data = 0
    end

    def revision
      1
    end

    def self.from_base64(sddl)
      from_byte_string(Base64.decode64(sddl))
    end

    def self.from_byte_string(sddl)
      descriptor = SecurityDescriptor.new

      raise Exception.new("Invalid revision in sddl") unless sddl.get_high_order_value(0) == 1

      descriptor.resource_manager_data = sddl.get_high_order_value(1)
      descriptor.flags = sddl.get_high_order_value(2, 2)

      raise Exception.new("SDDL should be self-relative") unless descriptor.self_relative?

      owner_offset = sddl.get_high_order_value(4, 4)
      if owner_offset != 0
        descriptor.owner = SecurityIdentifier.parse_binary(sddl, owner_offset)
      end

      group_offset = sddl.get_high_order_value(8, 4)
      if group_offset != 0
        descriptor.group = SecurityIdentifier.parse_binary(sddl, group_offset)
      end

      sacl_offset = sddl.get_high_order_value(12, 4)
      dacl_offset = sddl.get_high_order_value(16, 4)

      if sacl_offset != 0
        next_offset = [owner_offset, group_offset, dacl_offset, sddl.length].
          select { |x| x > sacl_offset }.
          min
        descriptor.sacl = sddl[sacl_offset, next_offset - sacl_offset]
      end

      if dacl_offset != 0
        next_offset = [owner_offset, group_offset, sacl_offset, sddl.length].
          select { |x| x > dacl_offset }.
          min
        descriptor.dacl = sddl[dacl_offset, next_offset - dacl_offset]
      end

      return descriptor
    end

    def to_base64
      Base64.strict_encode64(to_byte_string)
    end

    def to_byte_string
      base_offset = 0x14
      owner_offset = 0
      owner_bytes = ""
      group_offset = 0
      group_bytes = ""
      sacl_offset = 0
      sacl_bytes = ""
      dacl_offset = 0
      dacl_bytes = ""

      unless owner.nil?
        owner_bytes = owner.binary
        owner_offset = base_offset
        base_offset += owner_bytes.length
      end

      unless group.nil?
        group_bytes = group.binary
        group_offset = base_offset
        base_offset += group_bytes.length
      end

      unless sacl.nil? || sacl.length == 0
        sacl_offset = base_offset
        sacl_bytes = sacl
        base_offset += sacl_bytes.length
      end

      unless dacl.nil? || dacl.length == 0
        dacl_offset = base_offset
        dacl_bytes = dacl
        base_offset += dacl_bytes.length
      end

      "\x01#{resource_manager_data.to_high_order_byte_string}" +
      "#{flags.to_high_order_byte_string(2)}" +
      "#{owner_offset.to_high_order_byte_string(4)}" +
      "#{group_offset.to_high_order_byte_string(4)}" +
      "#{sacl_offset.to_high_order_byte_string(4)}" +
      "#{dacl_offset.to_high_order_byte_string(4)}" +
      owner_bytes +
      group_bytes +
      sacl_bytes + 
      dacl_bytes
    end

    def ==(o)
      state == o.state
    end
    alias_method :eql?, :==

    def hash 
      state.hash
    end

    def method_missing(name, *args, &block)
      flag_index = Flags.index { |flag| "#{flag}?" == "#{name}" || "#{flag}" == "#{name}" }
      if flag_index != nil
        return (flags & (1 << flag_index)) > 0
      end
      flag_index = Flags.index { |flag| "#{flag}=" == "#{name}" }
      if flag_index != nil && args.length == 1
        if args[0]
          self.flags |= (1 << flag_index)
        else
          self.flags &= (0xFFFF ^ (1 << flag_index))
        end
        return
      end
      super(name, *args, &block)
    end

    def respond_to_missing?(name, include_private=false)
      Flags.any? { |flag| "#{flag}?" == "#{name}" || "#{flag}" == "#{name}" || "#{flag}=" == "#{name}" } || super
    end

    protected

    Flags = [:owner_defaulted, :group_defaulted, :dacl_present, 
             :dacl_defaulted, :sacl_present, :sacl_defaulted,
             :server_security, :dacl_trusted, 
             :dacl_computed_inheritance_required, :sacl_computed_inheritance_required,
             :dacl_auto_inherited, :sacl_auto_inherited,
             :dacl_protected, :sacl_protected,
             :rm_control_valid, :self_relative]

    def state
      [owner, flags, group, resource_manager_data, sacl, dacl]
    end           

  end
end