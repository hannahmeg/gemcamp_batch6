# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

categories = ['Technology', 'Travel', 'Lifestyle', 'Fashion', 'Food']

categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

100.times do
  post = Post.create(title: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 0).chop,
                     content: Faker::Lorem.sentence(word_count: 300))
  rand(1..5).times do
    category = Category.all.sample
    next if post.categories.include? category

    post.categories << category

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


