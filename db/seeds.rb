# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "supersecret"
Review.destroy_all
Teacher.destroy_all
User.delete_all

super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD
)

50.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all


30.times do
  created_at = Faker::Date.backward(365 * 1)
  t = Teacher.create(
    # Faker is ruby module. We are just accessing
    # the class Hacker inside the module Faker
    description: Faker::ChuckNorris.fact,
    price: rand(20..35),
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )
      if t.valid?
        t.reviews = rand(1..3).times.map do
          Review.new(body: Faker::GreekPhilosophers.quote, rating: rand(2..3), user: users.sample)
        end
        # t.languages = rand(1..3).times.map do
        #   Languages.new(name: languages.sample)
        # end
      end
end

teachers = Teacher.all
reviews = Review.all

# puts Cowsay.say("Login with #{email} and password: #{PASSWORD}", :koala)
puts Cowsay.say("Generated #{ teachers.count } teachers", :ghostbusters)
# puts Cowsay.say("Generated #{ reviews.count } reviews", :stegosaurus)
