FactoryGirl.define do
  factory :invoice do
    customer_id 1
    merchant_id 1
    status "shipped"
  end
end
