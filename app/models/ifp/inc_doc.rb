#encoding: UTF-8

module IFP
	class IncDoc
		attr_reader :instance

		delegate :id, to: :instance, allow_nil: true
		delegate :sid, to: :instance, allow_nil: true
		delegate :sid=, to: :instance, allow_nil: true
		delegate :description, to: :instance, allow_nil: true
		delegate :description=, to: :instance, allow_nil: true

		def initialize(instance)
			@instance = instance
		end

		def resolutions
    		@resolutions ||= IncDocResolution.where(InstanceID: id).to_a || []
		end

		def assignment_tree
			assignments = resolutions.map { |x| x.assignment }.select { |x| !x.nil? }.to_a
			AssignmentTree.new([NamedSet.new("Рассмотрение", assignments)], nil)
		end
	end
end