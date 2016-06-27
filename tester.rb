require 'sqlite3'
require_relative "club_methods"

puts "Please enter your name."
member = gets.chomp

db = SQLite3::Database.open "#{member}.db"
puts "Welcome back, #{member}!"
puts

db.results_as_hash = true
virtual_bag = db.execute("SELECT * FROM virtual_bag")

# provide all clubs info and prompt to make changes
puts "Here is your virtual golf bag:"
clubs_printer(virtual_bag)
puts

# Apply WIP #2 ------------------------------------------
change = ""
until change == "n"
	puts "Do you need to make any changes? y/n"
	change = gets.chomp
	if change == "n"
		break
	end
	
	puts "Do you need to update club (u), add a club (a), or delete a club (d)?"
	choices = gets.chomp

	case choices
	when "u"
		puts "this is update"
	when "a"
		puts "this is add"
	when "d"
		puts "this is delete"
	else
		puts "Incorrect response.  Please start again."
	end
end
puts "End of loop"




# while change == "y"
# 	puts "Do you need to update, add, or delete? u/a/d"
# 	choices = gets.chomp
# 	case choices
# 	# when "u"
# 	# 	puts "Please select club to change"
# 	# 	update_club = gets.chomp
# 	# 	puts "Please enter a new club name or re-enter"
# 	# 	new_club = gets.chomp
# 	# 	puts "Please update the average yardage to the nearest 10s"
# 	# 	new_dist = gets.chomp
# 	# 	db.execute("UPDATE virtual_bag SET club_name=#{new_club}, dist_yards=#{new_dist} WHERE club_name=#{update_club}")

# 	# end
#     when "d"
#     	puts "Which club would you like to delete?"
#     	club_delete = gets.chomp
#     	db.execute("DELETE FROM virtual_bag WHERE club_name=#{club_delete}")
#     end
# 	puts "Are you all done with changes? y/n"
# 	all_done = gets.chomp
# 	if all_done == "n"
# 		redo
# 	end
# end





# puts "Are you already a member?"
# member = gets.chomp
# db = nil
# if member == "n"
# 	puts "enter your name"
# 	name = gets.chomp
# 	puts "enter a club"
# 	club = gets.chomp
# 	puts "enter average distance"
# 	distance = gets.chomp

# 	db = SQLite3::Database.new("#{name}.db")
	

# 	small_table = <<-SQL
# 		CREATE TABLE IF NOT EXISTS club (
# 			name VARCHAR(255),
# 			dist_yards INT
# 		)
# 	SQL

# 	db.execute(small_table)
# 	db.execute("INSERT INTO club (name, dist_yards) VALUES (?,?)", [club, distance])
# 	db.execute("INSERT INTO club (name, dist_yards) VALUES (?,?)", ["7i", 160])
# 	db.execute("INSERT INTO club (name, dist_yards) VALUES (?,?)", ["9i", 140])
# else
# 	puts "enter your name"
# 	member = gets.chomp

# 	db = SQLite3::Database.open "#{member}.db"
# 	puts "welcome back, #{member}!"
# end
# db.results_as_hash = true

# yardage = 142.78
# yrd_adjuster = ((yardage/10).floor * 10)
# yrd_adjuster

# clubs = db.execute("SELECT * FROM club")
# p clubs
# puts "here is test line"
# p clubs[0]["dist_yards"]
# puts "No club will be given if there is no yardage match.  Results are:"
# clubs.size.times do |club|
# 	if clubs[club]["dist_yards"] == yrd_adjuster
# 	puts "You should use your #{clubs[club]["name"]}"
# 	end
# end
# puts "Play this shot for adjusted yards of #{yrd_adjuster}"

# # trying to access specific index of database
# #puts "You should use your #{clubs[0]["name"]}"


