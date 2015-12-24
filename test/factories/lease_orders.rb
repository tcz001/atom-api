FactoryGirl.define do
  factory :lease_order do
    user nil
    status {[0,1,2,3,4,5].sample}
  end

end
