class Club < ActiveRecord::Base
  attr_accessible :name, :description
  
  has_many :lunches

  has_many :pending_memberships, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates_presence_of :name
  validates :description, :length => { :maximum => 200 }
end
