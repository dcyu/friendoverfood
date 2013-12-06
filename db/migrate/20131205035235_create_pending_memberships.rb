class CreatePendingMemberships < ActiveRecord::Migration
  create_table :pending_memberships do |t|
    t.belongs_to :user
    t.belongs_to :club
    t.boolean  "is_admin"
    t.timestamps
  end
end
