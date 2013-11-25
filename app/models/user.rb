class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :city, :is_verified

  has_many :lunches
  has_many :lunchers, through: :lunches
  has_many :inverse_lunches, class_name: "Lunch", foreign_key: "luncher_id"
  has_many :inverse_lunchers, through: :inverse_lunches, source: :user

  has_secure_password

  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6
  validates_presence_of :password, :on => :create

  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_uniqueness_of :email

  validates_presence_of :city
  validates_presence_of :first_name
  validates_presence_of :last_name


end
