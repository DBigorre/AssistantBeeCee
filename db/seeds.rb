# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p "creating links..."

link1 = Link.create(url: "https://fr.wikipedia.org/wiki/Martinique#:~:text=C'est%20un%20d%C3%A9partement%20et,ultrap%C3%A9riph%C3%A9rique%20de%20l'Union%20europ%C3%A9enne")
link2 = Link.create(url: "https://fr.wikipedia.org/wiki/France")
link3 = Link.create(url: "http://www.facebook.com")
link4 = Link.create(url: "http://www.lewagon.com")

p "#{link4.url}"
p "creating questions..."

question1 = Question.create(linked: false, query: "Comment allez-vous ?")
question2 = Question.create(linked: false, query: "Combien d'employés avez-vous ?")
question3 = Question.create(linked: false, query: "Recrutez-vous un chef de projet ?")
question4 = Question.create(linked: false, query: "Où sont vos locaux ?")

p "#{question4.query}"
p "finished!"
