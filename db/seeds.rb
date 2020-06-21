# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


 #runs our service objects to seed the database

artist_parser = Nokogiri::HTML::SAX::Parser.new(ArtistParser.new('artist'))
artist_file = File.join(__dir__, '/xmls/artist_test.xml')
artist_parser.parse(File.read(artist_file))



label_parser = Nokogiri::HTML::SAX::Parser.new(LabelParser.new('label'))
label_file = File.join(__dir__, '/xmls/label_test.xml')
label_parser.parse(File.read(label_file))
