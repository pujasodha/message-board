p 'Running seeds'

# users
3.times do
  User.create!(
    name: Faker::TvShows::BojackHorseman.character,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8)
  )
end

# posts & comments
10.times do
  post = Post.create!(
    user: User.find_by(id: rand(1...User.count)),
    title: Faker::Hipster.word,
    message: Faker::TvShows::BojackHorseman.quote
  )

  rand(1...10).times do
    Comment.create!(
      user: User.find_by(id: rand(1...User.count)),
      post: Post.find_by(id: post.id),
      body: Faker::Lorem.paragraph(sentence_count: 5)
    )
  end
end

p 'Seeds run successfully'
