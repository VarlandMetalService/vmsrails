FactoryBot.define do
  factory :salt_spray_test_check do
    c_type { "OK" }
    date   { '2018-11-07 15:00:00' }
    user
    salt_spray_test
  end
end