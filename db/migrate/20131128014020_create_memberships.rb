class CreateMemberships < ActiveRecord::Migration
  create_table :memberships do |t|
    t.belongs_to :user
    t.belongs_to :club
    t.timestamps
  end
end
