FactoryGirl.define do
  factory :prepaid_order do
    serial_number "MyString"
pay_type 1
status 1
total_amount "9.99"
user nil
  end

end
