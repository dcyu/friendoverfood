class Membership < ActiveRecord::Base
  attr_accessible :user_id, :club_id

  belongs_to :user
  belongs_to :club
end
