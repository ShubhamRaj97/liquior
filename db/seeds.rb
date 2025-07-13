# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "🌱 Seeding Doorkeeper applications..."

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: "liquior", redirect_uri: "http://localhost", scopes: "")
  puts "✅ OAuth applications seeded."
else
  puts "⚠️  OAuth applications already exist — skipping."
end

puts "🌱 Seeding users..."

# Use `find_or_create_by` with attributes for clarity
User.find_or_create_by!(email: "test@skysystemz.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "admin"
end

User.find_or_create_by!(email: "admin@example.com", role: "admin") do |user|
  user.password = "password"
  user.password_confirmation = "password"
end

puts "✅ Admin users seeded."

