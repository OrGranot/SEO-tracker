# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroy all websites'
Website.destroy_all
5.times do
  website = Website.new(name: "website", url: "www.website.com")
  website.user = User.find(3)
  website.save
  puts `Website #{website.id} created`
end
