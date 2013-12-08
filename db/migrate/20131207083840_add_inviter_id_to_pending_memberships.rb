class AddInviterIdToPendingMemberships < ActiveRecord::Migration
  def change
    add_column :pending_memberships, :inviter_user_id, :integer
  end
end
