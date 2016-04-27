FactoryGirl.define do
  factory :post do
    body "MyString"
    created_at Time.now
  end
end
