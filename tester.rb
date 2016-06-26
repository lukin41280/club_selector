require 'sqlite3'

puts "Are you already a member?"
member = gets.chomp
db = nil
if member == "n"
	puts "enter your name"
	name = gets.chomp
	puts "enter a club"
	club = gets.chomp
	puts "enter average distance"
	distance = gets.chomp

	db = SQLite3::Database.new("#{name}.db")
	

	small_table = <<-SQL
		CREATE TABLE IF NOT EXISTS club (
			name VARCHAR(255),
			dist_yards INT
		)
	SQL

	db.execute(small_table)
	db.execute("INSERT INTO club (name, dist_yards) VALUES (?,?)", [club, distance])
	db.execute("INSERT INTO club (name, dist_yards) VALUES (?,?)", ["7i", 160])
	db.execute("INSERT INTO club (name, dist_yards) VALUES (?,?)", ["9i", 140])
else
	puts "enter your name"
	member = gets.chomp

	db = SQLite3::Database.open "#{member}.db"
	puts "welcome back, #{member}!"
end
db.results_as_hash = true

yardage = 142.78
yrd_adjuster = ((yardage/10).floor * 10)
yrd_adjuster

clubs = db.execute("SELECT * FROM club")
p clubs
puts "here is test line"
p clubs[0]["dist_yards"]
puts "No club will be given if there is no yardage match.  Results are:"
clubs.size.times do |club|
	if clubs[club]["dist_yards"] == yrd_adjuster
	puts "You should use your #{clubs[club]["name"]}"
	end
end
puts "Play this shot for adjusted yards of #{yrd_adjuster}"

# trying to access specific index of database
#puts "You should use your #{clubs[0]["name"]}"


