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
  client_id: Client.all.map(&:id).sample
)
