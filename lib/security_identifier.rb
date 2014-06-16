require 'byte_strings'

module SDDL

  class SecurityIdentifier

    attr_reader :authority, :sub_authorities

    def initialize(authority, *sub_authorities)
      if authority.is_a?(String)
        initialize_with_string(authority)
      else
        @authority = authority
        @sub_authorities = sub_authorities.flatten
      end
    end

    def revision
      return 1
    end

    def to_s
      "S-#{revision}-#{authority}-#{sub_authorities.join('-')}" 
    end

    def ==(o)
      return false if authority != o.authority
      return false if sub_authorities != o.sub_authorities
      return true
    end
    alias_method :eql?, :==

    def hash 
      sub_authorities.hash
    end

    def self.parse_binary(byte_string, start = 0)
      if byte_string.getbyte(start) != 1
        raise Exception.new("Invalid SID revision")
      end
      sub_authority_count = byte_string.getbyte(1 + start)
      authority = byte_string.get_low_order_value(2 + start, 6)
      sub_authorities = []
      0.upto(sub_authority_count - 1).each { |index|
        sub_authorities << byte_string.get_high_order_value(start + 8 + 4 * index, 4)
      }
      return SecurityIdentifier.new(authority, sub_authorities)
    end

    def binary
      "\x01#{sub_authorities.length.to_low_order_byte_string}" +
      "#{authority.to_low_order_byte_string(6)}" +
      "#{sub_authorities.map { |x| x.to_high_order_byte_string(4) }.join}"
    end

    def size
      8 + sub_authorities.length * 4
    end

    protected 

    def initialize_with_string(sid_string)
      general_format = /^S-1((-\d+)+)$/.match(sid_string)
      raise Exception.new("Invalid sid") if general_format.nil?
      @sub_authorities = general_format[1].scan(/-(\d+)/).flatten.map { |x| x.to_i }
      @authority = @sub_authorities.shift
    end
  end
end

class String
  def to_sid
    SDDL::SecurityIdentifier.new(self)
  end
end