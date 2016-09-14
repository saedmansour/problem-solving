class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:student, :teacher, :admin]
	after_initialize :set_default_role, :if => :new_record?

	def set_default_role
		self.role ||= :student
	end       
end
