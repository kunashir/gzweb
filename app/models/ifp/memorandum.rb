#encoding: UTF-8

module IFP
	class Memorandum
		attr_reader :instance

		delegate :id, to: :instance, allow_nil: true
		delegate :sid, to: :instance, allow_nil: true
		delegate :sid=, to: :instance, allow_nil: true
		delegate :description, to: :instance, allow_nil: true
		delegate :description=, to: :instance, allow_nil: true

		def initialize(instance)
			@instance = instance
		end

		def assignments
    		@assignments ||= MemorandumAssignment.where(InstanceID: id).to_a || []
		end

		def approval_history
			@approval_history ||= MemorandumHistoryItem.where(InstanceID: id).to_a || []
		end

		def assignment_tree
			reviewAssignments = assignments.
				select { |x| (x.assignment_type || :review) == :review }.
				map { |x| x.assignment }.
				select { |x| !x.nil? }.to_a
			notifyAssigments = assignments.
				select { |x| x.assignment_type == :notify }.
				map { |x| x.assignment }.
				select { |x| !x.nil? }.to_a				
			tasks = approval_history.select { |x| !x.task.nil? }.
				map { |x| HistoryItem.new(
					"#{x.person.try(:display_name)}, #{x.resolution_text}",
					x.task,
					x.resolution == :improved ) }.to_a
			AssignmentTree.new(
				[NamedSet.new("Рассмотрение служебной записки", reviewAssignments),
				 NamedSet.new("Ознакомление со служебной запиской", notifyAssigments)], 
				NamedSet.new("Согласование", tasks))
		end
	end
end