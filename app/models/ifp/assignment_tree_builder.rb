module IFP
	
	class AssignmentTreeBuilder

		def self.build(document_id)
			document = Card.find(document_id).try(:card)
			return {} if document.nil?
			return {} unless document.respond_to?(:assignment_tree)
			build_tree(document.assignment_tree)
		end

		def self.build_tree(tree_data)
			return {} if tree_data.nil?
			return { "Branches" => build_assignment_groups(tree_data.assignments) } unless tree_data.assignments.nil?
			return {}
		end

		def self.build_assignment_groups(assignment_groups)
			assignment_groups.map { |group|
				{ "Title" => group.name, "Items" => build_assignments(group.values) }
			}
		end

		def self.build_assignments(assignments)
			nodes = assignments.each_slice(100).map { |x| 
				build_assignments_chunk(x)
			}.flatten

			build_assignments_tree(nodes)
		end

		def self.build_assignments_tree(nodes, assignment_id = nil)
			nodes.
				select { |x| x["ParentAssignmentID"] == assignment_id }.
				map { |x| 
					x["Children"] = build_assignments_tree(nodes, x["AssignmentID"]);
					x["StateName"] = TaskCard.state_name(x["State"], x["Type"]);
					x 
				}
		end

		def self.build_assignments_chunk(assignments)
			ids = assignments.map { |x| x.id }.join(";")
			Card.connection.execute_procedure("[dvreport_get_data_{622D9899-3CB6-48e4-8A85-64E3F3F1B6C8}]", ids)
		end

		def self.test
			AssignmentTreeBuilder.build_tree(Card.find(TaskInfo.first.parent_document_id).card.assignment_tree)
		end

	end

end