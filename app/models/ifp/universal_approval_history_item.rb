#encoding: UTF-8

module IFP

	class UniversalApprovalHistoryItem < ActiveRecord::Base
		self.table_name = "dvtable_{049DE6C2-5D14-4C4F-B982-95B87DF532E4}"
		self.primary_key = "RowID"

		belongs_to :person, class_name: 'TakeOffice::Employee', primary_key: 'RowID', foreign_key: 'Person'

		@@history_kinds = [
			:approving, :approved, :not_approved, 
			:correcting, :corrected, 
			:singing, :signed, 
			:cancelled, :not_signed]

		@@history_kind_texts = { 
			approving: 'На согласовании', approved: 'Согласовано', not_approved: 'Не согласовано', 
			correcting: 'На доработке', corrected: 'Доработано',
			singing: 'На подписании', signed: 'Подписано', 
			cancelled: 'Отменено', not_signed: 'Не подписано' }

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