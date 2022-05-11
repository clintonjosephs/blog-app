FactoryBot.define do
  factory :post do
    Title { Faker::Lorem.sentence }
    Text { Faker::Lorem.sentence }
    user_id { nil }
  end
end
