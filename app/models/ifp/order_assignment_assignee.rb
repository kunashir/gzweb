module IFP
	class OrderAssignmentAssignee < ActiveRecord::Base
		self.table_name = "dvtable_{98F1FA54-5148-4E51-A27B-01841659FEA5}"
		self.primary_key = "RowID"

		def assignment
			@assignment ||= load_assignment
		end

		private

		def load_assignment
			return nil if self.AssignmentID.nil?
			instance = Card.find(self.AssignmentID)
			return nil unless instance.CardTypeID == CardType.assignment_id
			return instance.card
		end
	end	
end