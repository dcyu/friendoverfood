class AddIsAdminToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :is_admin, :boolean
  end
end
