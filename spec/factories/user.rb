FactoryBot.define do
  factory :user do
    name      { Faker::TvShows::BojackHorseman.character }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password(min_length: 8) }
  end
end
