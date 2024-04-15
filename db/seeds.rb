# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

100.times do
  user = User.create(email: Faker::Internet.email, password: "123456", username: Faker::Internet.unique.user_name, address: Faker::Address.full_address, phone_number: Faker::PhoneNumber.cell_phone_in_e164)
end

100.times do |index|
  user = User.all.sample  # Get a random user
  post = user.posts.create(title: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 0).chop,
                           content: Faker::Lorem.paragraph)

  num_categories = rand(1..4)

  categories = ['Technology', 'Travel', 'Lifestyle', 'Fashion', 'Food'].sample(num_categories)

  categories.each do |category_name|
    post.categories.find_or_create_by(name: category_name)
  end
end

20.times do |index|
  student = Student.create(
    name: Faker::Name.name,
    student_number: Faker::Number.number(digits: 6),
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 30)
  )

  4.times do
    student.phone_numbers.create(content: Faker::PhoneNumber.cell_phone_in_e164)
  end
end

