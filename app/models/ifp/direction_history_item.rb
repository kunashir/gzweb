#encoding: UTF-8

module IFP

	class DirectionHistoryItem < ActiveRecord::Base
		self.table_name = "dvtable_{340ACD6F-6001-4C40-8B9F-55CC74127313}"
		self.primary_key = "RowID"

		belongs_to :person, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Person'

		@@history_kinds = [
			:approval_started, :approved, :not_approved, 
			:corrected, :signing, :sigined, :not_signed, 
			:correcting, :cancelled, :approving, 
			:on_registration, :registered, :on_signing,
			:prepared_signing, :send_on_correction]
		@@history_kind_texts = { 
			approval_started: 'Согласование начато', approved: 'Согласовано', not_approved: 'Не согласовано', 
			corrected: 'Доработано', signing: 'На подписании', sigined: 'Подписано', not_signed: 'Не подписано', 
			correcting: 'На доработке', cancelled: 'Отклонено', approving: 'На согласовании', 
			on_registration: 'На регистрации', registered: 'Зарегистрирован', on_signing: 'На подготовке к подписанию',
			prepared_signing: 'Подготовлено к подписанию', send_on_correction: 'Отправлено на доработку' }

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
			return nil if self.TaskID.nil?
			instance = Card.find(self.TaskID)
			return nil unless instance.CardTypeID == CardType.workflow_task_id
			return instance.card
		end
	end

end