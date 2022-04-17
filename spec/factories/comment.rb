FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
