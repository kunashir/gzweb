module TakeOffice

	class RefStaff

    def self.InstanceID
      @@instanceID ||= Card.where(card_type: CardType.ref_staff).first.InstanceID
    end

    def self.departments
      TakeOffice::Department.root
    end

	end

end