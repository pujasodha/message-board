p 'Running seeds'

# users
3.times do |_i|
  User.create!(
    name: Faker::TvShows::BojackHorseman.character,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8)
  )
end

# posts
10.times do |_i|
  Post.create!(
    user: User.find_by(id: rand(1...User.count)),
    title: Faker::Hipster.word,
    message: Faker::TvShows::BojackHorseman.quote
  )
end

p 'Seeds run successfully'
