class Lunch < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :lunch_requests
  has_many :users, through: :lunch_requests
end
