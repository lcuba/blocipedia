# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

7.times do
    User.create!(
        email: Faker::Internet.email,
        password: Faker::Internet.password
    )
end
users = User.all
users.skip_confirmation!
users.save!

standard_user = User.new(
    email: "standard@standard.com",
    password: "asdfjkl;",
    role: "standard"
)
standard_user.skip_confirmation!
standard_user.save!

premium_user = User.new(
    email: "premium@premium.com",
    password: "asdfjkl;",
    role: "premium"
)
premium_user.skip_confirmation!
premium_user.save!

admin_user = User.new(
    email: "admin@admin.com",
    password: "asdfjkl;",
    role: "admin"
)
admin_user.skip_confirmation!
admin_user.save!

#dummy_user = User.new(
#    email: "dummy@dummy.com",
#    password: "asdfjkl;",
#    role: "standard"
#)
#dummy_user.skip_confirmation!
#dummy_user.save!

20.times do
   Wiki.create!(
        user: users.sample,
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph,
        private: false
    ) 
end

5.times do
    Wiki.create!(
        user: users.sample,
        title: Faker::Lorem.sentence + " - Private",
        body: Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph,
        private: true
    ) 
    end


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"

