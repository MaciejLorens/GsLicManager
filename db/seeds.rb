# ----- CLIENTS: -------------------------------------------------------------------------------------------------------
Client.create(name: 'Tesla', locale: %w(pl en).sample)
Client.create(name: 'Spacex', locale: %w(pl en).sample)
Client.create(name: 'Solarcity', locale: %w(pl en).sample)
Client.create(name: 'Boring', locale: %w(pl en).sample)


# ----- SUPER_ADMINS: --------------------------------------------------------------------------------------------------
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


# ----- ADMINS: --------------------------------------------------------------------------------------------------------
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


# ----- USERS: ---------------------------------------------------------------------------------------------------------
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


# ----- APPS: ----------------------------------------------------------------------------------------------------------
app1 = App.create(name: 'Allscales SW software')
app2 = App.create(name: 'Allscales EW software')
app3 = App.create(name: 'Allscales BW software')


# ----- PLANS: ---------------------------------------------------------------------------------------------------------
app1.plans.create(val_pl: 'Podstawowy', val_en: 'Basic')
app1.plans.create(val_pl: 'Premium', val_en: 'Premium')
app2.plans.create(val_pl: 'Premium Plus', val_en: 'Premium Plus')
app3.plans.create(val_pl: 'Zaawansowany', val_en: 'Advanced')


# ----- STATUSES: ------------------------------------------------------------------------------------------------------
LicenseStatus.create(val_pl: 'Nowa', val_en: 'New')
LicenseStatus.create(val_pl: 'Zarejestrowana', val_en: 'Registered')
LicenseStatus.create(val_pl: 'Zablokowana', val_en: 'Blocked')


# ----- TYPES: ---------------------------------------------------------------------------------------------------------
new_type = LicenseType.create(val_pl: 'Nowa', val_en: 'New')
update_type = LicenseType.create(val_pl: 'Aktualizacja', val_en: 'Update')
transfer_type = LicenseType.create(val_pl: 'Transfer', val_en: 'Transfer')


# ----- VERSIONS: ------------------------------------------------------------------------------------------------------
20.times do
  app = App.all.to_a.sample

  app.versions.create(
    number: "#{rand(10)}.#{rand(20)}.#{rand(10)}",
    created_at: rand(100).days.ago
  )
end


# ----- LICENSES: (NEW TYPE) -------------------------------------------------------------------------------------------
10.times do
  client = Client.all.to_a.sample
  app = App.all.to_a.sample
  license_status = LicenseStatus.all.to_a.sample

  License.create(
    client_id: client.id,
    app_id: app.id,
    version_id: app.versions.sample.id,
    plan_id: app.plans.sample.id,
    license_type_id: new_type.id,
    license_status_id: license_status.id,
    order_number: "order_number_#{SecureRandom.hex(2)}",
    end_client_name: "end_client_name_#{SecureRandom.hex(2)}",
    installation_address: "installation_address_#{SecureRandom.hex(2)}",
    description: "description_#{SecureRandom.hex(2)}",
    created_at: rand(100).days.ago,
    origin_id: nil
  )
end


# ----- LICENSES: (UPDATE TYPE) ----------------------------------------------------------------------------------------
10.times do
  client = Client.all.to_a.sample
  app = App.all.to_a.sample
  license_status = LicenseStatus.all.to_a.sample

  License.create(
    client_id: client.id,
    app_id: app.id,
    version_id: app.versions.sample.id,
    plan_id: app.plans.sample.id,
    license_type_id: update_type.id,
    license_status_id: license_status.id,
    order_number: "order_number_#{SecureRandom.hex(2)}",
    end_client_name: "end_client_name_#{SecureRandom.hex(2)}",
    installation_address: "installation_address_#{SecureRandom.hex(2)}",
    description: "description_#{SecureRandom.hex(2)}",
    created_at: rand(100).days.ago,
    origin_id: new_type.licenses.sample.id
  )
end

# ----- LICENSES: (TRANSFER TYPE) --------------------------------------------------------------------------------------
10.times do
  client = Client.all.to_a.sample
  app = App.all.to_a.sample
  license_status = LicenseStatus.all.to_a.sample

  License.create(
    client_id: client.id,
    app_id: app.id,
    version_id: app.versions.sample.id,
    plan_id: app.plans.sample.id,
    license_type_id: transfer_type.id,
    license_status_id: license_status.id,
    order_number: "order_number_#{SecureRandom.hex(2)}",
    end_client_name: "end_client_name_#{SecureRandom.hex(2)}",
    installation_address: "installation_address_#{SecureRandom.hex(2)}",
    description: "description_#{SecureRandom.hex(2)}",
    created_at: rand(100).days.ago,
    origin_id: new_type.licenses.sample.id
  )
end


# ----- INVITATIONS: ---------------------------------------------------------------------------------------------------
12.times do |index|
  client = Client.all.to_a.sample

  Invitation.create(
    email: "maciej.lorens+#{index}@gmail.com",
    locale: %w(en pl).sample,
    client_id: client.id,
    role: %w(user admin).sample
  )
end
