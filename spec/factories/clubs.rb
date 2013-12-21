FactoryGirl.define do
  factory :club do
    name { Faker::Lorem.words(1).first }
    description { Faker::Lorem.sentences(1).first }
  end
end
