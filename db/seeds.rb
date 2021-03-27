# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create({email: 'test@gmail.com', password: 'qwerty'})
product = Product.create({name: 'product_test', price: 100, stock: 50, scheduled_start: "2021-03-26 17:31:00.000000000 +0800", scheduled_end: "2021-04-26 17:31:00.000000000 +0800", user_id: user.id})