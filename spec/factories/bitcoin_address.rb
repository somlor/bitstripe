FactoryGirl.define do
  factory :bitcoin_address, aliases: [:destination_address] do
    user
    address 'abc'
  end
end
