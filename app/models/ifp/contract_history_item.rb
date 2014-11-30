#encoding: UTF-8

module IFP

	class ContractHistoryItem < ActiveRecord::Base
		self.table_name = "dvtable_{E79A6914-9A7A-467C-93CB-5A2F30BB5C52}"
		self.primary_key = "RowID"

		belongs_to :person, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Person'

		@@history_kinds = [
			:approval_started, :approved, :not_approved, 
			:corrected, :on_correction, :declined,
			:on_approval, :approved_with_comments,
			:on_signing, :sigined, :not_signed, 
			:change_OI, :recalled, :recall,
			:received, :declined_by_counteragent, 
			:accepted_started, :accepted,
			:request_check_started, :request_checked,
			:not_accepted, :not_request_checked,
			:request_correct_started, :request_corrected]

		@@history_kind_texts = { 
			approval_started: 'Согласование начато', approved: 'Согласовано', not_approved: 'Не согласовано', 
			corrected: 'Доработано', on_correction: 'На доработке', declined: 'Отклонено',
			on_approval: 'На согласовании', approved_with_comments: 'Согласовано с протоколом',
			on_signing: 'На подписании', sigined: 'Подписано', not_signed: 'Не подписано', 
			change_OI: 'Изменен ответственный исполнитель', recalled: 'Отозвано', recall: 'Договор отозван',
			received: 'Подписан к/а', declined_by_counteragent: 'Не подписан к/а', 
			accepted_started: 'Акцептование заявки начато', accepted: 'Заявка утверждена',
			request_check_started: 'Проверка заявки', request_checked: 'Заявка проверена',
			not_accepted: 'Заявка не утверждена', not_request_checked: 'Заявка отклонена проверяющим',
			request_correct_started: 'Доработка заявки', request_corrected: 'Заявка доработана' }

		def history_kind
			return nil if self.HistoryKind.nil?
			@@history_kinds[self.HistoryKind]
		end

		def task
			@task ||= load_task
		end

		def history_kind_text
			@@history_kind_texts[history_kind]
		end

		private

		def load_task
			return nil if self.Task.nil?
			instance = Card.find(self.Task)
			return nil unless instance.CardTypeID == CardType.workflow_task_id
			return instance.card
		end
	end

end