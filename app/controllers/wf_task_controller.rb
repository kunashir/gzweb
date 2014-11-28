#encoding: UTF-8

class WFTaskController < ApplicationController
	
	def details
		task = Card.find(params[:id]).card
		description = task.description
		if description =~ /, Не начато$/i
			description = description[0..-12]
		end
		result = {
			"Name" => description, 
			"Author" => task.main_info.author.try(:display_name),
		}
		result["Performers"] = get_performers(task)

		unless task.create_date.nil?
			if task.create_date.hour == 0 && task.create_date.min == 0
				result["CreationDate"] = task.create_date.strftime('%d.%m.%Y')
			else
				result["CreationDate"] = task.create_date.strftime('%d.%m.%Y %H:%M') 
			end
		end

		unless task.main_info.deadline.nil?
			result["Deadline"] = task.main_info.deadline.strftime('%d.%m.%Y %H:%M')
		end

		result["State"] = task.performing.state_name
		unless task.performing.actual_end_date.nil?
			result["State"] += ", " + task.performing.actual_end_date.strftime('%d.%m.%Y %H:%M')
		end
		
		result["Content"] = task.main_info.comments
		result["PerformerFiles"] = get_files(task.main_info.performer_files)

		result["PerformerComment"] = task.comments.select { |x| x.is_report && !x.text.blank? }.first.try(:text)

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

	 def get_performers(task)
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
        return performers
	end
end