#encoding: UTF-8

module IFP

	class MemorandumHistoryItem < ActiveRecord::Base
		self.table_name = "dvtable_{2DEC53A1-850A-4AF5-BD07-D6149E4199BE}"
		self.primary_key = "RowID"

		belongs_to :person, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Person'

		@@resolutions = [
			:approving, :approved, :not_approved, 
			:signing, :sigined, :not_signed, 
			:improving, :improved, :cancelled, 
			:on_registration, :registered]
		@@resolution_texts = { 
			approving: 'На согласовании', approved: 'Согласовано', not_approved: 'Не согласовано',
			signing: 'На подписании', signed: 'Подписано', not_signed: 'Не подписано',
			improving: 'На доработке', improved: 'Доработано', cancelled: 'Отклонена',
			on_registration: 'На регистрации', registered: 'Зарегистрирован' }

		def resolution
			return nil if self.Resolution.nil?
			@@resolutions[self.Resolution - 1]
		end

		def task
			@task ||= load_task
		end

		def resolution_text
			@@resolution_texts[resolution]
		end

		private

		def load_task
			return nil if self.TaskID.nil?
			instance = Card.find(self.TaskID)
			return nil unless instance.CardTypeID == CardType.workflow_task_id
			return instance.card
		end
	end

end