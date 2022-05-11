FactoryBot.define do
  factory :comment do
    Text { Faker::Lorem.sentence }
    user_id { nil }
    post_id { nil }
  end
end
