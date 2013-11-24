class CreateLunches < ActiveRecord::Migration
  def change
    create_table :lunches do |t|

      t.timestamps
    end
  end
end
