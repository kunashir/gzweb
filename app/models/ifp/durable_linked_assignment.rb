module IFP
	class DurableLinkedAssignment < ActiveRecord::Base
		self.table_name = "dvtable_{FF34D0B5-13B7-42CD-944B-702D42AE1023}"
		self.primary_key = "RowID"

		def assignment
			@assignment ||= load_assignment
		end

		private

		def load_assignment
			return nil if self.LinkedAssignment.nil?
			instance = Card.find(self.LinkedAssignment)
			return nil unless instance.CardTypeID == CardType.assignment_id
			return instance.card
		end
	end	
end