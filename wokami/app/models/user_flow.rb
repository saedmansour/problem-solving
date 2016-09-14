#no longer used, belongs to old q&a wokami

class UserFlow < ActiveRecord::Base
  belongs_to :user
  belongs_to :flow
  belongs_to :subject
end
