# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#if Rails.env.development?
  Admin.create!(email: "admin@test.com", password: "password")
#end
# Tag.create([
#   { name: 'うどん' },
#   { name: 'マカロニ・スパゲティ' },
#   { name: '中華麺' },
#   { name: 'そうめん' },
#   { name: 'そば' }
# ])