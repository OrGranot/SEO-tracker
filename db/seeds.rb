# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning database..."
Website.destroy_all

user1 = User.first
user2 = User.last

puts "Creating Websites..."
web1 = { name: "אילת", url: "www.h-eilat.co.il", user_id: user1.id}
web2 =  { name: "מרוקו", url: "www.mrco.co.il", user_id: user1.id}
web3 =  { name: "מרוקו", url: "www.mrco.co.il", user_id: user1.id}
web4 =  { name: "ברלין", url: "www.berlinil.co.il", user_id: user.id}
web5 =  { name: "ynet", url: "www.ynet.co.il", user_id: user.id}

[ web1, web2 ].each do |attributes|
  website = Website.create!(attributes)
  puts "Created #{website.name}"
end


puts "Creating keywords"

Website.all.each do |website|
  3.times do
    string =  3.times.map { (0...(rand(10))).map { ('a'..'z').to_a[rand(26)] }.join }.join(" ")
    keyword = Keyword.new(key_string: string)
    keyword.website = website
    keyword.save


  end
end

puts "Finished!"
