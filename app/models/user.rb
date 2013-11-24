class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :city

  has_many :lunches
  has_many :lunchers, through: :lunches
  has_many :inverse_lunches, class_name: "Lunch", foreign_key: "luncher_id"
  has_many :invere_lunchers, through: :inverse_lunches, source: :user

  has_secure_password

  validates_uniqueness_of :email
  validates_presence_of :email
  validates_presence_of :password, :on => :create

end
