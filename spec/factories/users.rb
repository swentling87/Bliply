FactoryGirl.define do
  factory :user do
    email "user@bliply.com"
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Date.today
  end
end
