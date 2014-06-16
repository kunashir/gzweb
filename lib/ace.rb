require 'byte_strings'

module SDDL
  class Ace

    attr_reader :type, :mask, :sid, :flags, :object_type, :inherit_object_type

    def initialize
      @mask = 0
      @object_type = 0
      @inherit_object_type = 0
      @flags = []
    end

    def binary
      binary =
        "#{Types[type].chr}" +
        "#{flags.map { |flag| Flags[flag] }.reduce(0) { |r, f| r | f }.chr}" +
        "#{size.to_high_order_byte_string(2)}" +
        "#{mask.to_high_order_byte_string(4)}"
      if [:allowed_object, :denied_object].member?(type)
        binary += (((object_type == 0)?0:0x1) | ((inherit_object_type == 0)?0:0x2)).to_high_order_byte_string(4)
        binary += object_type.to_high_order_byte_string(16)
        binary += inherit_object_type.to_high_order_byte_string(16)
      end
      binary += sid.binary
    end

    def size
      return 8 + sid.size if [:allowed, :denied].member?(type)
      return 8 + 4 + 16 + 16 + sid.size if [:allowed_object, :denied_object].member?(type)
      return 0
    end

    def self.allowed(mask, sid, *flags)
      ace = Ace.new
      ace.send(:init_simple, :allowed, mask, sid, *flags)
    end

    def self.denied(mask, sid, *flags)
      ace = Ace.new
      ace.send(:init_simple, :denied, mask, sid, *flags)
    end

    def self.allowed_object(mask, sid, object_type, inherit_object_type, *flags)
      ace = Ace.new
      ace.send(:init_simple_object, :allowed_object, mask, sid, object_type, inherit_object_type, *flags)
    end

    def self.denied_object(mask, sid, object_type, inherit_object_type, *flags)
      ace = Ace.new
      ace.send(:init_simple_object, :denied_object, mask, sid, object_type, inherit_object_type, *flags)
    end

    def self.parse_binary(binary, start = 0)
      ace = Ace.new
      ace.send(:init_binary, binary, start)
    end

    protected 

    def init_binary(binary, start = 0)
      @type = Types.key(binary.getbyte(start))
      binary_flags = binary.getbyte(start + 1)
      @flags = Flags.select { |flag, value| binary_flags & value > 0 }.
        map { |flag, value| flag }
      @mask = binary.get_high_order_value(start + 4, 4)
      index = start + 8
      if [:allowed_object, :denied_object].member?(@type)
        index += 4
        @object_type = binary.get_high_order_value(index, 16)
        index += 16
        @inherit_object_type = binary.get_high_order_value(index, 16)
        index += 16
      end
      @sid = SecurityIdentifier.parse_binary(binary, index)

      return self
    end

    def init_simple(type, mask, sid, *flags)
      flags = flags.flatten

      raise Exception.new("SID is not set or is not SecurityIdentifier") if sid.nil? || !sid.is_a?(SecurityIdentifier)
      raise Exception.new("Invalid flags") if flags.any? { |x| Flags[x].nil? }

      @type = type
      @mask = mask
      @sid = sid
      @flags = flags
      return self
    end

    def init_simple_object(type, mask, sid, object_type, inherit_object_type, *flags)
      flags = flags.flatten

      raise Exception.new("SID is not set or is not SecurityIdentifier") if sid.nil? || !sid.is_a?(SecurityIdentifier)
      raise Exception.new("Invalid flags") if flags.any? { |x| Flags[x].nil? }

      @type = type
      @mask = mask
      @sid = sid
      @object_type = object_type
      @inherit_object_type = inherit_object_type
      @flags = flags
      return self
    end

    Types = { allowed: 0x00, denied: 0x01, audit: 0x02, alarm: 0x03,
              allowed_compound: 0x04, allowed_object: 0x05, denied_object: 0x06,
              audit_object: 0x07, alarm_object: 0x08,
              allowed_callback: 0x09, denied_callback: 0x0A,
              allowed_callback_object: 0x0B, denied_callback_object: 0x0C,
              audit_callback: 0x0D, alarm_callback: 0x0E,
              audit_callback_object: 0x0F, alarm_callback_object: 0x10,
              mandatory_label: 0x11, resource_attribute: 0x12,
              scoped_policy_id: 013 }

    Flags = { object_inherit: 0x01, container_inherit: 0x02, 
              no_propagate_inherit: 0x04, inherit_only: 0x08,
              inherited: 0x10,
              successful_access: 0x40, failed_access: 0x80 }  
  end
  
end