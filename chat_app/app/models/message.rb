class Message < ApplicationRecord
	belongs_to :conversation
	
	after_commit { MessageRelayJob.perform_later(self) }

	def sender
		User.find(self.sender_id)
	end
end
