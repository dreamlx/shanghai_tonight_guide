# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    place_id ""
    user_name "MyString"
    phone "MyString"
    description "MyText"
  end
end
