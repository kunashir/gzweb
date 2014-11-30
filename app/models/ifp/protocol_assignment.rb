module IFP
	class ProtocolAssignment < ActiveRecord::Base
		self.table_name = "dvtable_{6E71A21C-FA5B-4218-8A17-1F47AEBA4CD5}"
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