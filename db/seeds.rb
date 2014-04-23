# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create!({:email => "kevin.w.chang@gmail.com", :password => "12345678", :password_confirmation => "12345678" })
s = Stack.create(name: "TEST DATA")
s.cards << Card.create(question: "What is Bogo sort?", 
  answer: "[Shuffle](http://www.youtube.com/watch?v=DaPJkYo2quc) until sorted.")
s.cards << Card.create(question: "TestQ", answer: "Test A")
u.stacks << s
u.cards << u.stacks.first.cards


# User.create(email: "dory@test.com", password: "testswordfish", password_confirmation: "test")