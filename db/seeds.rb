# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning database..."
Website.destroy_all

puts "Creating restaurants..."
web1 = { name: "bitesew", url: "www.website.com", user_id: 3}
web2 =  { name: "East", url: "www.website-also.com", user_id: 3}

[ web1, web2 ].each do |attributes|
  website = Website.create!(attributes)
  puts "Created #{website.name}"
end
puts "Finished!"
