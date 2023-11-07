10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.paragraph(sentence_count: 3, supplemental: true),
    password: "password",
    email: Faker::Internet.email(domain: 'yopmail.com'))
end

5.times do
  Event.create(
    start_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 60), 
    duration: [15, 30, 60, 90, 120].sample, 
    title: Faker::Lorem.sentence(word_count: 3), 
    description: Faker::Lorem.characters, 
    price: Faker::Number.within(range: 1..100),
    location: Faker::Address.city)
end

15.times do 
  Attendance.create(
    stripe_customer_id: "stringtest",
    user_id: User.all.sample.id, 
    event_id: Event.all.sample.id)
end