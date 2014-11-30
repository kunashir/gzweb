#encoding: UTF-8

module IFP

	class ProtocolHistoryItem < ActiveRecord::Base
		self.table_name = "dvtable_{9E22DA46-F4D2-4F24-A6BA-032508651CEF}"
		self.primary_key = "RowID"

		belongs_to :person, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'PersonHistory'

		@@history_kinds = [
			:on_approving, :approved, :not_approved, 
			:on_correcting, :corrected, 
			:on_signing, :sigined, :not_signed, 
			:cancelled ]
		@@history_kind_texts = { 
			on_approving: 'На согласовании', approved: 'Согласовано', not_approved: 'Не согласован',
			on_correcting: 'На доработке', corrected: 'Доработан', 
			on_signing: 'На подписании', sigined: 'Подписан', not_signed: 'Не подписан', 
			cancelled: 'Отменен' }

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
			return nil if self.TaskHistory.nil?
			instance = Card.find(self.TaskHistory)
			return nil unless instance.CardTypeID == CardType.workflow_task_id
			return instance.card
		end
	end

end