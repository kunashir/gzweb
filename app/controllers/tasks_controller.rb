#encoding: UTF-8

require 'take_office/employee'
require 'dvcore/security'

class TasksController < ApplicationController

  def new
    @task = Task.new.init(current_user)
    @quick_performers = TakeOffice::Employee.all.take(6)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: { task: @task } }
    end
  end

  def create
    performer = TakeOffice::Employee.where(RowID: params[:performer]).first unless 
      params[:performer].nil? || params[:performer].blank?
    error ||= 'Исполнитель не задан' if performer.nil?
    content = params[:content]
    error ||= 'Не задано содержание поручения' if content.blank?
    begin
      deadline = Time.strptime(params[:deadline], "%d.%m.%Y %H:%M")
      deadline += Time.zone_offset(deadline.zone)
    rescue
      deadline = nil
    end
    controller = TakeOffice::Employee.where(RowID: params[:controler]).first unless 
      params[:controler].nil? || params[:controler].blank?
    co_performers = []
    co_performers = [TakeOffice::Employee.where(RowID: params[:co_performers]).first] unless 
      params[:co_performers].nil? || params[:co_performers].blank?
    informants = []
    informants = [TakeOffice::Employee.where(RowID: params[:informants]).first] unless 
      params[:informants].nil? || params[:informants].blank?
    if error.nil?
      begin
        card = TaskCard.new
     
        sid = CardType.assignment.sid
        unless TaskSetup.instance.task_folder.nil? || TaskSetup.instance.task_folder.sid.nil?
          sid = TaskSetup.instance.task_folder.sid
        end
        unless current_employee.nil? || sid.nil? || current_employee.account_sid.blank?
          sdesc = sid.sdesc
          sdesc.owner = current_employee.account_sid.to_sid
          sid = DVCore::Security.new
          sid.sdesc = sdesc
          sid.save!
        end

        refs = RefListCard.new
        refs.sid = sid
        refs.save!

        files = FileListCard.new
        files.sid = sid
        unless params[:files].nil?
          params[:files].each { |file_id| 
            file = FileCard.find(file_id)
            unless file.nil?
              file.sid = sid
              file.save!

              files.add_file(file)
            end
          }
        end
        files.save!

        card.sid = sid
        card.description = "Поручение от " + Time.now.strftime("%d.%m.%Y")
        card.main_info.author = current_employee
        card.main_info.registrator = current_employee
        card.main_info.controller = controller
        card.main_info.content = content
        card.main_info.add_performer(performer)
        co_performers.each { |co_performer| 
          card.main_info.add_co_performer(co_performer)
        }
        informants.each { |informant| 
          card.main_info.add_acquaintance(informant)
        }
        card.main_info.deadline = deadline
        card.main_info.refs_list = refs
        card.main_info.file_list = files
        card.main_info.state = :executing
        card.save!

        unless TaskSetup.instance.task_folder.nil?
          TaskSetup.instance.task_folder.add_hard_shortcut(card.id)
        end

        process = ProcessCard.find(Card.copy_card(TaskSetup.process_template_id))
        process.instance.is_template = false
        process.sid = TaskSetup.instance.process_folder.sid
        TaskSetup.instance.process_folder.add_hard_shortcut(process.id)
        process.description = card.description + ". Запуск обработки поручений"
        process.main_info.name = card.description + ". Запуск обработки поручений"
        process.save!
        task_var_id = process.find_variable('Поручения')
        unless task_var_id.nil?
          ProcessVariableValue.create!(InstanceID: process.id, ParentRowID: task_var_id, Value: card.id, Identity: 0, UseSparedValue: false)
        end

        process.start
      rescue Exception => ex
        error = ex.message
        error = "Внутреняя ошибка приложения" if error.blank?
        logger.error ex.message
        e.backtrace.each { |line| logger.error line }
      end
    end
    
    if error.nil? || error.blank?
      respond_to do |format|
        format.json { render json: { result: :ok }, status: 200 }
      end
    else
      respond_to do |format|
        format.json { render json: { error: error }, status: 406 }
      end
    end
  end

  def show
  end
end