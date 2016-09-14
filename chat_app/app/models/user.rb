class User < ApplicationRecord
	has_many :conversations
	#has_many/one :apps for admins
end
