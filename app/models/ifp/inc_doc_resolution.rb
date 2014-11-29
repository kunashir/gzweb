module IFP
	class IncDocResolution < ActiveRecord::Base
		self.table_name = "dvtable_{AD95E7FB-592C-4CAA-BBDF-25F32F0B2987}"
		self.primary_key = "RowID"

		def assignment
			@assignment ||= load_assignment
		end

		private

		def load_assignment
			return nil if self.ResolutionID.nil?
			instance = Card.find(self.ResolutionID)
			return nil unless instance.CardTypeID == CardType.assignment_id
			return instance.card
		end
	end	
end