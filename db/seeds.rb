# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create({name: 'test', email: 'test@gmail.com', password: 'qwerty', admin: true})
product = Product.create({name: 'product_test', price: 100, stock: 50, scheduled_start: "2021-03-26 17:31:00.000000000 +0800", scheduled_end: "2021-04-26 17:31:00.000000000 +0800", user_id: admin.id})

user1 = User.create({email: 'aa@aa.com', password: 'qwerty'})
product1 = Product.create({name: 'aa.NO1', price:100, stock: 100, scheduled_start: "2021-03-2 17:31:00.000000000 +0800", scheduled_end: "2021-04-2 17:31:00.000000000 +0800", user_id: user1.id})
product2 = Product.create({name: 'aa.NO2', price:200, stock: 200, scheduled_start: "2021-03-20 17:31:00.000000000 +0800", scheduled_end: "2021-04-20 17:31:00.000000000 +0800", user_id: user1.id})

user2 = User.create({email: 'bb@bb.com', password: 'qwerty'})
product3 = Product.create({name: 'bb.NO1', price:300, stock: 300, scheduled_start: "2021-03-27 17:31:00.000000000 +0800", scheduled_end: "2021-04-27 17:31:00.000000000 +0800", user_id: user2.id})
product4 = Product.create({name: 'bb.NO2', price:400, stock: 400, scheduled_start: "2021-03-23 17:31:00.000000000 +0800", scheduled_end: "2021-04-23 17:31:00.000000000 +0800", user_id: user2.id})