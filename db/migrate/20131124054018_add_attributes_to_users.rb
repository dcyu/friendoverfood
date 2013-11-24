class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :city, :string
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
    add_column :users, :is_verified, :boolean
  end
end
