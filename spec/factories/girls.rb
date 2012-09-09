# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :girl, :class => 'Girls' do
    name "MyString"
    age 1
    livein "MyString"
    desc "MyText"
  end
end
