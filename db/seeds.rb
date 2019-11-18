Client.create(name: 'Tesla', locale: %w(pl en).sample)
Client.create(name: 'Spacex', locale: %w(pl en).sample)
Client.create(name: 'Solarcity', locale: %w(pl en).sample)
Client.create(name: 'Boring', locale: %w(pl en).sample)

User.create(
  first_name: "Maciej",
  last_name: "Lorens",
  email: "maciej.lorens@gmail.com",
  password: '1234567890',
  password_confirmation: '1234567890',
  locale: 'pl',
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
    locale: %w(pl en).sample,
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
    locale: %w(pl en).sample,
    role: 'user',
    client_id: client.id,
    created_at: rand(100).days.ago
  )
end

App.create(name: 'Scale')
App.create(name: 'Management')
App.create(name: 'CMS')

Type.create(value: 'basic', en: 'Basic', pl: 'Podstawowy')
Type.create(value: 'optimum', en: 'Optimum', pl: 'Optymalny')
Type.create(value: 'advanced', en: 'Advanced', pl: 'Zaawansowany')


20.times do |index|
  app = App.all.to_a.sample

  app.versions.create(
    value: "value_#{SecureRandom.hex(2)}",
    number: "#{rand(10)}.#{rand(20)}.#{rand(10)}",
    created_at: rand(100).days.ago
  )
end

20.times do |index|
  version = Version.all.to_a.sample
  user = User.where(role: 'user').to_a.sample
  type = Type.all.to_a.sample

  user.licenses.create(
    end_client_name: "end_client_name_#{SecureRandom.hex(2)}",
    end_client_address: "end_client_address_#{SecureRandom.hex(2)}",
    status: License::STATUSES.sample,
    description: "description_#{SecureRandom.hex(2)}",
    order_number: "order_number_#{SecureRandom.hex(2)}",
    registration_key: "registration_key_#{SecureRandom.hex(2)}",
    type_id: type.id,
    version_id: version.id,
    client_id: user.client.id,
    created_at: rand(100).days.ago
  )
end

12.times do |index|
  client = Client.all.to_a.sample

  Invitation.create(
    email: "maciej.lorens+#{index}@gmail.com",
    locale: %w(en pl).sample,
    client_id: client.id,
    role: %w(user admin).sample
  )
end
