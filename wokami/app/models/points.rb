class Points < ActiveRecord::Base
  belongs_to :user
  belongs_to :chapter
end
