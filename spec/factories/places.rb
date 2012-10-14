# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place do
    place_name "MyString"
    area_id 1
    address "MyString"
    category_id 1
    user_id 1
    desciption "MyText"
    glat "MyString"
    glng "MyString"
    price "9.99"
    phone "MyString"
  end
end
