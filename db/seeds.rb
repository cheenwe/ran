# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
    email: "admin@qq.com",
    name: "admin",
    password:"123123123",
    confirmed_at: Time.now
    )
p "*"*80
p "admin create succsss."
p "account:  admin@qq.com "
p "password:  123123123 "
p "*"*80