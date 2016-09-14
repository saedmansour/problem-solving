class Conversation < ApplicationRecord
	belongs_to :app
	belongs_to :client, foreign_key: "client_id", class_name: "User"
	belongs_to :admin, foreign_key: "admin_id", class_name: "User"

	has_many :messages
end
