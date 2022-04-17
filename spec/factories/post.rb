FactoryBot.define do
  factory :post do
    title   { Faker::Hipster.word }
    message { Faker::TvShows::BojackHorseman.quote }
  end
end
