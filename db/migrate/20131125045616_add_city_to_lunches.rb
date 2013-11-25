class AddCityToLunches < ActiveRecord::Migration
  def change
    add_column :lunches, :city, :string
  end
end
