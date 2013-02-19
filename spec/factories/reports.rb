# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    place_id 1
    user_id 1
    title "MyString"
    body "MyText"
  end
end
