# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "Mom", email: "", role: "client")
User.create!(name: "Granny", email: "", role: "client")
User.create!(name: "Auntie", email: "", role: "client")

bill 		= User.create!(name: "Bill Gates", email: "bill@microsoft.com", role: "admin")
ballmer = User.create!(name: "Steve Ballmer", email: "bill@microsoft.com", role: "admin")

App.create!(name: "MS Office 2007", admin_id: bill.id)
App.create!(name: "Windows Me", admin_id: bill.id)
App.create!(name: "Windows Vista", admin_id: ballmer.id)
App.create!(name: "IE 6", admin_id: bill.id)


