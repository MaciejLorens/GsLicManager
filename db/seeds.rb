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

User.create(
  first_name: "Robert",
  last_name: "Trawiński",
  email: "robert@gs-software.pl",
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

App.create(name: 'Allscales SW software')
App.create(name: 'Allscales EW software')
App.create(name: 'Allscales BW software')

LicensePlan.create(val_pl: 'Podstawowy', val_en: 'Basic')
LicensePlan.create(val_pl: 'Premium', val_en: 'Premium')
LicensePlan.create(val_pl: 'Premium Plus', val_en: 'Premium Plus')

LicenseStatus.create(val_pl: 'Nowa', val_en: 'New')
LicenseStatus.create(val_pl: 'Zarejestrowana', val_en: 'Registered')
LicenseStatus.create(val_pl: 'Zablokowana', val_en: 'Blocked')

LicenseType.create(val_pl: 'Nowa', val_en: 'New')
LicenseType.create(val_pl: 'Aktualizacja', val_en: 'Update')
LicenseType.create(val_pl: 'Transfer', val_en: 'Transfer')

20.times do |index|
  app = App.all.to_a.sample

  app.versions.create(
    number: "#{rand(10)}.#{rand(20)}.#{rand(10)}",
    created_at: rand(100).days.ago
  )
end

20.times do |index|
  version = Version.all.to_a.sample
  client = Client.all.to_a.sample
  license_plan = LicensePlan.all.to_a.sample
  license_status = LicenseStatus.all.to_a.sample
  license_type = LicenseType.all.to_a.sample

  License.create(
    end_client_name: "end_client_name_#{SecureRandom.hex(2)}",
    end_client_address: "end_client_address_#{SecureRandom.hex(2)}",
    description: "description_#{SecureRandom.hex(2)}",
    order_number: "order_number_#{SecureRandom.hex(2)}",
    registration_key: "registration_key_#{SecureRandom.hex(2)}",
    license_plan_id: license_plan.id,
    license_status_id: license_status.id,
    license_type_id: license_type.id,
    version_id: version.id,
    app_id: version.app.id,
    client_id: client.id,
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
