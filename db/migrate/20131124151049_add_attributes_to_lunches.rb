class AddAttributesToLunches < ActiveRecord::Migration
  def change
    add_column :lunches, :user_id, :integer
    add_column :lunches, :luncher_id, :integer
  end
end
