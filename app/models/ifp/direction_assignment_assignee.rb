module IFP
	class DirectionAssignmentAssignee < ActiveRecord::Base
		self.table_name = "dvtable_{99D4B0EC-585F-4C71-8128-D6834C6E44C0}"
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