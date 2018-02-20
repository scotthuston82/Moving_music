# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password',
    kind: 'client',
    bio: Faker::Lorem.paragraph,
    hourly_rate_in_cents: nil,
    lat: (43.76 + rand * 0.01),
    long: (-79.41 + rand * 0.01),
    profile_picture: nil,
  )
end

10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password',
    kind: 'musician',
    bio: Faker::Lorem.paragraph,
    hourly_rate_in_cents: rand(10000..40000),
    lat: (43.76 + rand * 0.01),
    long: (-79.41 + rand * 0.01),
    profile_picture: "https://picsum.photos/200/300/?random"
  )
end
