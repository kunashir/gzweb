require 'security_descriptor'

module DVCore

  class Security < ActiveRecord::Base
    self.table_name = "dvsys_security"
    self.primary_key = "ID"

    before_create :assign_id

    def sdesc
      SDDL::SecurityDescriptor.from_base64(self.SecurityDesc)
    end

    def sdesc=(value)
      self.SecurityDesc = value.to_base64
    end

    def self.create_security(security_descriptor)
      Security.create!(SecurityDesc: security_descriptor.to_base64)
    end

    protected 

    def assign_id
      self.ID = SecureRandom.uuid
    end
  
  end

end