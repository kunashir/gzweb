require 'byte_strings'
require 'security_identifier'
require 'base64'

class SecurityDescriptor
  attr_accessor :owner, :flags, :group, :resource_manager_data

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
      descriptor.owner = SecurityIdentifier.from_byte_string(sddl, owner_offset)
    end

    group_offset = sddl.get_high_order_value(8, 4)
    if group_offset != 0
      descriptor.group = SecurityIdentifier.from_byte_string(sddl, group_offset)
    end

    return descriptor
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
    [owner, flags, group, resource_manager_data]
  end           

end