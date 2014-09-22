# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

titles = [
  "Bicycle",
  "Bicycle 2",
  "Billy",
  "Cage",
  # "Nude in Garden",
  "No Games",
  "Self Portrait"
]

titles.each do |title|
  Etching.create(title: title)
end