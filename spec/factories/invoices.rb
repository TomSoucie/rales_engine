FactoryGirl.define do
  factory :invoice do
    # customer nil
    # merchant nil
    status "Paid"
  end

  customer
  merchant
end
