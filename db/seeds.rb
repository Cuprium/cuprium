# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

dm = DataManager.create!(email:'example@cuprium.org',password:'example1234',password_confirmation:'example1234',first_name:'Test',last_name:'Test',title_id:1) if DataManager.find_by_email('example@cuprium.org').blank?

(1..5).each { |acc| Account.new(number:"acc#{acc}",owner:"test#{acc}",type:"share").save } if Account.all.blank?

[ {name:'payment',direction:1},
  {name:'withdrawal',direction:-1},
  {name:'transfer_in',direction:1},
  {name:'tramsfer_out',direction:-1},
].each { |entry| Entry.create(entry) }
