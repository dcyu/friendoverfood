# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    city "Chicago"
    email "john@john.com"
    password "password"
    password_confirmation "password"
  end
end
