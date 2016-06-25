require 'sqlite3'

puts "Are you already a member?"
member = gets.chomp
if member == "n"
	puts "enter your name"
	name = gets.chomp
	puts "enter a club"
	club = gets.chomp
	puts "enter average distance"
	distance = gets.chomp

	$DB = SQLite3::Database.new("#{name}.db")
	$DB.results_as_hash = true

	# create_club_table = <<-SQL
	# 	CREATE TABLE IF NOT EXISTS test(
	# 		low5 INT,
	# 		low4 INT,
	# 		low3 INT,
	# 		low2 INT,
	# 		low1 INT,
	# 		entry INT,
	# 		high1 INT,
	# 		high2 INT,
	# 		high3 INT,
	# 		high4 INT
	# 	)
	# SQL


	# db.execute(create_club_table)

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
end

exist_db = SQLite3_load_extension("jay.db")
yardage = 142.78
yrd_adjuster = ((yardage/10).floor * 10)
yrd_adjuster

clubs = exist_db.execute("SELECT * FROM club")
#p clubs
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


