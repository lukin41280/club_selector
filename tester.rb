require 'sqlite3'

puts "enter your name"
name = gets.chomp
puts "enter a club"
club = gets.chomp
puts "enter average distance"
distance = gets.chomp

db = SQLite3::Database.new("#{name}.db")
db.results_as_hash = true

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

yardage = 151.3
yrd_adjuster = ((yardage/10).floor * 10).to_s
yrd_adjuster

clubs = db.execute("SELECT * FROM club")
p clubs
puts "here is test line"
if clubs["dist_yards"] == yrd_adjuster
	puts "You should use your #{clubs["name"]}"
end

# trying to access specific index of database



