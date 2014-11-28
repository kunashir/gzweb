#encoding: UTF-8

class AssignmentController < ApplicationController
	
	def details
		assignment = Card.find(params[:id]).card
		description = assignment.description
		if description =~ /, Не начато$/i
			description = description[0..-12]
		end
		result = {
			"Name" => description, 
			"Author" => assignment.main_info.author.try(:display_name),
			"Controller" => assignment.main_info.controller.try(:display_name)
		}
		if assignment.main_info.for_acquaintance && !assignment.main_info.acquaintances.empty?
			result["Performers"] = assignment.main_info.acquaintances.
				map { |x| x.assignee.try(:display_name) }.
				select { |x| !x.blank? }.to_a
		else
			result["Performers"] = assignment.main_info.performers.
				map { |x| x.assignee.try(:display_name) }.
				select { |x| !x.blank? }.to_a
		end
		result["CoPerformers"] = assignment.main_info.co_performers.
			map { |x| x.assignee.try(:display_name) }.
			select { |x| !x.blank? }.to_a

		unless assignment.create_date.nil?
			if assignment.create_date.hour == 0 && assignment.create_date.min == 0
				result["CreationDate"] = assignment.create_date.strftime('%d.%m.%Y')
			else
				result["CreationDate"] = assignment.create_date.strftime('%d.%m.%Y %H:%M') 
			end
		end

		unless assignment.main_info.deadline.nil?
			result["Deadline"] = assignment.main_info.deadline.strftime('%d.%m.%Y %H:%M')
		end

		result["State"] = assignment.main_info.state_name
		result["Content"] = assignment.main_info.content

		result["AuthorFiles"] = get_files(assignment.main_info.file_list)

		task = assignment.main_info.assignee_task ||
			assignment.main_info.performers.map { |x| x.task }.first

		result["PerformerFiles"] = get_files(task.main_info.performer_files) unless task.nil? || task.main_info.nil?

		result["History"] = assignment.history_data

		render json: result
	end

	private 

	def get_files(file_list)
		return [] if file_list.nil?
		file_list.references.
			map { |x| x.file }.
			select { |x| !x.nil? }.
			map { |x| { "Name" => x.file_name, "ID" => x.id } }
	end
end