class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :city

  has_many :lunch_requests
  has_many :lunches, through: :lunch_requests

  has_secure_password

  validates_uniqueness_of :email
  validates_presence_of :email
  validates_presence_of :password, :on => :create

end
