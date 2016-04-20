FactoryGirl.define do
  factory :user do
    name "bliply"
    age 30
    gender 3
    email "user@bliply.com"
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Date.today
  end
end
