FactoryBot.define do
  factory :user do
    first_name { 'Test name' }
    last_name { 'Test last name' }
    sequence(:username) { |n| "User_#{n}" }
    sequence(:email) { |n| "test#{n}@email.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    role { :regular }
  end
end
