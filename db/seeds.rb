User.destroy_all
Booking.destroy_all
Genre.destroy_all

Genre.create!(name: "Pop/Top 40")
Genre.create!(name: "Hip-Hop")
Genre.create!(name: "Motown")
Genre.create!(name: "Funk")
Genre.create!(name: "Rock")
Genre.create!(name: "Reggae")
Genre.create!(name: "Jazz")
Genre.create!(name: "Punk")
Genre.create!(name: "80's")
Genre.create!(name: "Bluegrass")
Genre.create!(name: "Cajun Slam-grass")
Genre.create!(name: "Nickelback-Trash-Rock")

5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password',
    kind: 'client',
    bio: Faker::Lorem.paragraph,
    hourly_rate: nil,
    lat: (43.76 + rand * 0.01),
    long: (-79.41 + rand * 0.01),
    profile_picture: "empty_profile.png"
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
    hourly_rate: rand(100..400),
    lat: (43.76 + rand * 0.01),
    long: (-79.41 + rand * 0.01),
    profile_picture: "https://picsum.photos/200/300/?random",
    stage_name: Faker::Kpop.boy_bands,
    act_type: ["dj", "band"].sample,
    genres: Genre.all.sample(rand(1..4))
  )
end

20.times do
  Booking.new(
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
  booking.save
end
