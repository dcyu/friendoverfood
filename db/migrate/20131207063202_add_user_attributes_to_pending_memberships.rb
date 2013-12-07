class AddUserAttributesToPendingMemberships < ActiveRecord::Migration
  def change
    add_column :pending_memberships, :user_first_name, :string
    add_column :pending_memberships, :user_last_name, :string
    add_column :pending_memberships, :user_email, :string
  end
end
