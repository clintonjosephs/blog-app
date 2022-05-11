FactoryBot.define do
  factory :user do
    Name { Faker::Name.name }
    Photo { Faker::Avatar.image }
    Bio { Faker::Lorem.sentence }
    email { Faker::Internet.email }
    password { 'secret' }
    password_confirmation { password }
    confirmed_at { Time.now }
    role { 'admin' }
  end
end
