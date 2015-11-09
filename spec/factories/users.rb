FactoryGirl.define do
  factory :user do
    email "user@gmail.com"
    password { my_password }
    password_confirmation { password }
  end
end
