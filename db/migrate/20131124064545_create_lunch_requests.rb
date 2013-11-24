class CreateLunchRequests < ActiveRecord::Migration
  def change
    create_table :lunch_requests do |t|
      t.belongs_to :lunch
      t.belongs_to :user

      t.timestamps
    end
  end
end
