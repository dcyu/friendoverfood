class PendingMembership < ActiveRecord::Base
  attr_accessible :user_id, :club_id, :user_first_name, :user_last_name, :user_email


  # validates_presence_of :user_email
  # validates_format_of :user_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  # validates_uniqueness_of :user_email

  belongs_to :user
  belongs_to :club
end
