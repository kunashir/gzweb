#encoding: UTF-8

module IFP

	class DurableAssignment
		attr_reader :instance

		delegate :id, to: :instance, allow_nil: true
		delegate :sid, to: :instance, allow_nil: true
		delegate :sid=, to: :instance, allow_nil: true
		delegate :description, to: :instance, allow_nil: true
		delegate :description=, to: :instance, allow_nil: true

		def initialize(instance)
			@instance = instance
		end

		def linked_assignments
    		@linked_assignments ||= DurableLinkedAssignment.where(InstanceID: id).to_a || []
		end

		def assignment_tree
			executionAssignments = linked_assignments.
				map { |x| x.assignment }.
				select { |x| !x.nil? }.to_a

			AssignmentTree.new(
				[NamedSet.new("Исполнение", executionAssignments)], 
				nil)

		end
	end

end