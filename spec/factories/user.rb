FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    password '12345678'
    password_confirmation { |y| y.password }
  end
end
