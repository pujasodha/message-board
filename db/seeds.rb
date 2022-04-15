p 'Running seeds'

# posts
10.times do |_i|
  Post.create!(
    title: Faker::Lorem.word,
    message: Faker::Lorem.paragraphs(number: 2)
  )
end

p 'Seeds run successfully'
