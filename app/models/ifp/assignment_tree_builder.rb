#encoding: UTF-8

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
			tree = { "branches" => [] }
			tree["branches"] += build_assignment_groups(tree_data.assignments) unless tree_data.assignments.nil?
			tree["branches"] << build_tasks_branch(tree_data.tasks) unless tree_data.tasks.nil? || tree_data.tasks.length == 0
			return tree
		end

		def self.build_assignment_groups(assignment_groups)
			assignment_groups.map { |group|
				{ "title" => group.name, "items" => build_assignments(group.values) }
			}.select {
				|x| !x["items"].nil? && x["items"].length > 0
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
					x["children"] = build_assignments_tree(nodes, x["AssignmentID"]);
					x["StateName"] = TaskCard.state_name(x["State"], x["Type"]);
					x 
				}
		end

		def self.build_assignments_chunk(assignments)
			ids = assignments.map { |x| x.id }.join(";")
			Card.connection.execute_procedure("[dvreport_get_data_{622D9899-3CB6-48e4-8A85-64E3F3F1B6C8}]", ids)
		end

		def self.build_tasks_branch(task_set)
			{ "title" => task_set.name, "cycles" => build_tasks(task_set.values) }
		end

		def self.build_tasks(tasks)
			nodes = tasks.each_slice(100).map { |x| 
				build_tasks_chunk(x.map { |i| i.task })
			}.flatten.uniq { |x| x["AssignmentID"] }

			build_tasks_tree(tasks, nodes)
		end

		def self.build_tasks_tree(tasks, nodes)
			cycles_count = tasks.count { |x| x.is_correction } + (tasks.first.try(:is_correction) ? 0 : 1)
			cycle_node = { name: "Цикл #{cycles_count}", items: [] }
			cycles = [ cycle_node ]

			tasks.each do |history_item|

                task_node = { name: (history_item.task.nil? ? history_item.name : build_task_name(history_item.task)) }
				task_node[:task_id] = history_item.task.try(:id)

                task_node[:children] = nodes.
                	select { |x| x["WFTaskID"] == task_node[:task_id] }.
                	map { |x| 
						x["children"] = build_assignments_tree(nodes, x["AssignmentID"]);
						x["StateName"] = TaskCard.state_name(x["State"], x["Type"]);
						x 
					}

				if history_item.is_correction
					cycles_count -= 1
					cycle_node = { name: "Цикл #{cycles_count}", items: [] }
               	end

               	cycle_node[:items] << task_node
            end

            return cycles
		end

		def self.build_tasks_chunk(tasks)
			ids = tasks.map { |x| x.id }.join(";")
			Card.connection.execute_procedure("[dvreport_get_data_{630986E2-5636-45cf-BA8F-3FFABECAE6AA}]", ids)
		end

		def self.build_task_name(task)
			return "" if task.nil?
			"#{build_task_current_performer(task)}, #{build_task_state(task)}"
		end

		def self.build_task_state(task)
            state = ""
            if task.performing.state == :completed
            	if task.completion_params.length > 0
                    completion_param = task.completion_params.first
                    selected_value = completion_param.value
                    enum_value = completion_param.enum_values.where("ValueID" => selected_value).first
                    state = enum_value.name unless enum_value.nil?
                end
            end
            state = task.performing.state_name if task.nil?
            return state
        end

        def self.build_task_current_performer(task)
            performers = []
            included = []
            task.current_performers.each do |performer|
            	next if performer.performer.nil? || performer.deputy_for.nil? || included.include?(performer.performer.id)

                performers << "#{performer.deputy_for.display_name} (#{performer.performer.display_name})"

                included << performer.performer.id
                included << performer.deputy_for.id

            end
            task.current_performers.each do |performer|
            	next if performer.performer.nil? || !performer.deputy_for.nil? || included.include?(performer.performer.id)
                
                performers << "#{performer.performer.display_name}"
                included << performer.performer.id

           	end
           	performers_text = performers.join(", ")
           	if task.performing.state == :completed
                completed_by = task.performing.completed_employee
                unless completed_by.nil? || included.include?(completed_by.id)
                    performers_text += " (" + completed_by.display_name + ")"
                end
            end
            return performers_text
		end

		def self.test
			AssignmentTreeBuilder.build_tree(Card.find(TaskInfo.first.parent_document_id).card.assignment_tree)
		end

	end

end