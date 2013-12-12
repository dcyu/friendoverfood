# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    email "admin@friendoverfood.com"
    password "password"
    password "password_confirmation"
  end
end
