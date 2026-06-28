1# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Student.create!([
    { first_name: "John", last_name: "Doe", email: "john.doe@example.com" },
    { first_name: "Jane", last_name: "Smith", email: "jane.smith@example.com" },
    { first_name: "Bob", last_name: "Johnson", email: "bob.johnson@example.com" }
])