module IFP
	class MemorandumAssignment < ActiveRecord::Base
		self.table_name = "dvtable_{4E8CFFE9-07AD-44D1-B651-BC73BF628A24}"
		self.primary_key = "RowID"

		@@assignment_types = [:review, :notify]

		def assignment_type
			return nil if self.AssignmentType.nil?
			@@assignment_types[self.AssignmentType]
		end

		def assignment
			@assignment ||= load_assignment
		end

		private

		def load_assignment
			return nil if self.AssignmentId.nil?
			instance = Card.find(self.AssignmentId)
			return nil unless instance.CardTypeID == CardType.assignment_id
			return instance.card
		end
	end	
end