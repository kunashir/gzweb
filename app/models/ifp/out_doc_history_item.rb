#encoding: UTF-8

module IFP

	class OutDocHistoryItem < ActiveRecord::Base
		self.table_name = "dvtable_{20FFD567-A851-4E10-8548-6DCCA0FCB020}"
		self.primary_key = "RowID"

		belongs_to :person, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Person'

		@@resolutions = [
			:approving, :approved, :not_approved,
			:signing, :sigined, :not_signed, 
			:improving, :improved, :cancelled, :recall,
			:prepare_signing, :prepared_signing,
			:send_on_correction, 
			:preparing_to_send, :prepared_to_send]

		@@resolution_texts = { 
			approving: 'На согласовании', approved: 'Согласован', not_approved: 'Не согласован',
			signing: 'На подписании', sigined: 'Подписан', not_signed: 'Не подписан', 
			improving: 'На доработке', improved: 'Доработан', cancelled: 'Отклонен', recall: 'Отозван',
			prepare_signing: 'На подготовке к подписанию', prepared_signing: 'Подготовлен к подписанию',
			send_on_correction: 'Отправлено на доработку', 
			preparing_to_send: 'Подготовка к отправке', prepared_to_send: 'Подготовлен к отправке' }

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