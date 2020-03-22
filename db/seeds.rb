# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: "admin@example.com", password: "password")
Country.create!(name: "india")
State.create!(name: "kerala", country_id: 1)
District.create!(name: "alappuzha", state_id: 1)
District.create!(name: "ernakulam", state_id: 1)
District.create!(name: "idukki", state_id: 1)
District.create!(name: "kannur", state_id: 1)
District.create!(name: "kollam", state_id: 1)
District.create!(name: "kottayam", state_id: 1)
District.create!(name: "kozhikode", state_id: 1)
District.create!(name: "malappuram", state_id: 1)
District.create!(name: "palakkad", state_id: 1)
District.create!(name: "pathanamthitta", state_id: 1)
District.create!(name: "thiruvananthapuram", state_id: 1)
District.create!(name: "thrissur", state_id: 1)
District.create!(name: "wayanad", state_id: 1)