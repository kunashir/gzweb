#encoding: UTF-8

module IFP

	class UniversalApproval
		attr_reader :instance

		delegate :id, to: :instance, allow_nil: true
		delegate :sid, to: :instance, allow_nil: true
		delegate :sid=, to: :instance, allow_nil: true
		delegate :description, to: :instance, allow_nil: true
		delegate :description=, to: :instance, allow_nil: true

		def initialize(instance)
			@instance = instance
		end

		def approval_history
			@approval_history ||= UniversalApprovalHistoryItem.where(InstanceID: id).to_a || []
		end

		def assignment_tree
			tasks = approval_history.select { |x| !x.task.nil? }.
				map { |x| HistoryItem.new(
					"#{x.person.try(:display_name)}, #{x.history_kind_text}",
					x.task,
					x.history_kind == :corrected ) }.to_a

			AssignmentTree.new(
				[], 
				NamedSet.new("Согласование", tasks))

		end
	end

end