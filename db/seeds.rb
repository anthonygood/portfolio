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
  "Bottles",
  "Cage",
  "Cats",
  "Fishes",
  "Garden Nude",
  "Hinge",
  "Look Right",
  # "Nude in Garden",
  "No Games",
  "Nude and Cloth",
  "Self Portrait"
]

titles.each do |title|
  Etching.create(title: title)
end