Client.create(name: 'Tesla')
Client.create(name: 'Spacex')
Client.create(name: 'Solarcity')
Client.create(name: 'Boring')

User.create(
  first_name: "Maciej",
  last_name: "Lorens",
  email: "maciej.lorens@gmail.com",
  password: '1234567890',
  password_confirmation: '1234567890',
  role: 'super_admin',
  client_id: nil,
  created_at: rand(100).days.ago
)

6.times do |index|
  client = Client.all.to_a.sample

  User.create(
    first_name: "first_#{index}",
    last_name: "last_#{index}",
    email: "admin#{index}@gs.com",
    password: '1234567890',
    password_confirmation: '1234567890',
    role: 'admin',
    client_id: nil,
    created_at: rand(100).days.ago
  )
end

12.times do |index|
  client = Client.all.to_a.sample

  User.create(
    first_name: "first_#{index}",
    last_name: "last_#{index}",
    email: "user#{index}@gs.com",
    password: '1234567890',
    password_confirmation: '1234567890',
    role: 'user',
    client_id: client.id,
    created_at: rand(100).days.ago
  )
end

