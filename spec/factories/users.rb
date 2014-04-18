# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    sequence :email do |n|
      "test#{n}@test.com"
    end
    password "123123abcdef"
    password_confirmation { "123123abcdef" }
  end
end
