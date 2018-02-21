User.destroy_all
Booking.destroy_all

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

20.times do
  Booking.create!(
    musician_id: rand(6..15),
    client_id: rand(1..5),
    start_time: Time.now + rand(3..30).days,
    address: "220 King St W, Suite 200, Toronto, ON M5H 1K4",
    party_size: [nil, rand(50..200)].sample,
    age_range: [nil, "18 - 24", "25 - 35", "35 - 45", "45+"].sample
  )
end

Booking.all.each do |booking|
  booking.end_time = booking.start_time + rand(3..6).hours
end
