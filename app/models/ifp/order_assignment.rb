module IFP
	class OrderAssignment < ActiveRecord::Base
		self.table_name = "dvtable_{37E44E13-884E-4AC2-8B60-9E4B4FBD48B4}"
		self.primary_key = "RowID"

		def assignment
			@assignment ||= load_assignment
		end

		private

		def load_assignment
			instance = Card.find(self.AssignmentID)
			return nil unless instance.CardTypeID == CardType.assignment_id
			return instance.card
		end
	end	
end