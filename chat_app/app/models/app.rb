class App < ApplicationRecord
	attr_accessor :admin

	has_many :users
	has_many :conversations

	def admin
		User.find(self.admin_id)
	end
end
