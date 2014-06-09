module DVCore
  
  class Binary < ActiveRecord::Base
    self.table_name = "dvsys_binaries"
    self.primary_key = "ID"

    before_create :assign_id

    def self.create_binary(filename, content)
      Binary.create!( 
        Type: /\.[^\.]*$/.match(filename).to_s,
        Data: content)
    end

    protected 

    def assign_id
      self.ID = SecureRandom.uuid
    end
  end
end