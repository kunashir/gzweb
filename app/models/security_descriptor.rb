class SecurityDescriptor < ActiveRecord::Base
  self.table_name = "dvsys_security"
  self.primary_key = "ID"
end