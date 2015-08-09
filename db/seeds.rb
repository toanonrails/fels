User.create!(
  name: "Admin",
  email: "admin@fels.com",
  password: "123",
  activated: true,
  admin: true)

17.times do |n|
  name     = Faker::Name.name
  email    = "user#{n+1}@fels.com"
  password = "123"
  User.create!(
    name:      name,
    email:     email,
    password:  password,
    activated: true)
end

5.times do
  name = Faker::Lorem.sentence 4
  description = Faker::Lorem.paragraph 5
  Category.create! name: name, description: description
end

categories = Category.all
categories.each do |category|
  5.times do
    word = Word.new content: Faker::Lorem.word, category_id: category.id
    word.save validate: false

    4.times do
      word.options.create! content: Faker::Lorem.word
    end
    word.options.first.update_attributes correct: true
  end
end