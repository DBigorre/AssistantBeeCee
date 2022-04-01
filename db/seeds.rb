# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

p "destroy all"
Question.destroy_all
Link.destroy_all

p "creating links..."

link0 = Link.create!(url: nil)
link1 = Link.create!(url: "https://www.linkedin.com/company/beecee-agency/jobs/", tag_list: "recrutement")
link2 = Link.create!(url: "https://g.page/beecee?share", tag_list: "contact")
link3 = Link.create!(url: "https://www.facebook.com/beeceedesign/", tag_list: "réseaux sociaux")
link4 = Link.create!(url: "https://www.php.net/", tag_list: "métiers")
link5 = Link.create!(url: "https://www.beecee.fr/", tag_list: "collaborateurs")

p "#{link4.url}"
p "creating questions..."

question1 = Question.create!(linked: false, query: "Quelle est votre spécialité ?", link: link5)
question2 = Question.create!(linked: false, query: "Combien d'employés êtes-vous ?", link: link5)
question3 = Question.create!(linked: false, query: "Recrutez-vous un chef de projet ?", link: link1)
question4 = Question.create!(linked: false, query: "Votre page Facebook ?", link: link4)
question5 = Question.create!(linked: false, query: "On peut travailler ensemble ?", link: link2)
question6 = Question.create!(linked: false, query: "Recrutez-vous des développeurs ?", link: link1)
question7 = Question.create!(linked: false, query: "Quel langage de programmation utilisez-vous ?", link: link4)
question8 = Question.create!(linked: false, query: "Où sont vos locaux ?", link: link2)

p "#{question4.query}"
p "finished!"
