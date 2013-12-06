class AddClubIdToLunches < ActiveRecord::Migration
  def change
    add_column :lunches, :club_id, :integer
  end
end
