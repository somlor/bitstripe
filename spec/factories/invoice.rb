FactoryGirl.define do
  factory :invoice do
    user
    destination_address
    btc_cost 0.25
    # satoshi_cost 25000000 # 0.25 btc
  end
end
