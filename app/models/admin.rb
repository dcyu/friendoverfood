class Admin < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation


  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6
  validates_presence_of :password, :on => :create

  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_uniqueness_of :email

  before_save do
    self.email = self.email.downcase
  end
  
  has_secure_password

end
