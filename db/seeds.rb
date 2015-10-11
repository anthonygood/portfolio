# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative '../lib/csv_translator'

t = CSVTranslator.new "#{Rails.root}/db/portfolio.csv", Etching
t.write_records_to_db()

if t.errors?
  puts "There were errors writing the following records to the database:"
  puts t.translations_with_errors
else
  puts "There were no errors to report."
end
