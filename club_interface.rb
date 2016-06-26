# program that will provide a golfer what club they should use depending upon 
# multiple factors affecting their shot such as wind, slope, and temperature.
# methods are created to adjust the yardage the golfer will have to account 
# from their imputs.  the golfer will need to set up the distancces upfront
# on how far they hit each club and this will be stored into a database titled 
# as their name. once the questions regarding the shot conditions are answered,
# the program will print the club to use based off the adjusted yardage. 

require_relative "club_methods"
require "SQLite3"

## setting up golfer's clubs database
puts "What is your name?"
name = gets.chomp
db = SQLite3::Database.new("#{name}.db")
db.results_as_hash = true

## create table to hold user entered clubs
clubs_table = <<-SQL
		CREATE TABLE IF NOT EXISTS virtual_bag (
			club_name VARCHAR(255),
			dist_yards INT
		)
	SQL
db.execute(clubs_table)

## have user add clubs and distances to the club table
club = ""
until club == "d"
	puts "Enter a club or type 'd' if finished"
	club = gets.chomp
	if club == "d"
		puts "Virtual golf bag completed"
		puts
		break
	end
	puts "Enter the average distance (only use yardage to the nearest 10s. ex - 130, 160, etc.)"
	dist = gets.chomp
	db.execute("INSERT INTO virtual_bag (club_name, dist_yards) VALUES (?,?)", [club, dist])
end

virtual_bag = db.execute("SELECT * FROM virtual_bag")

# provide all clubs info and prompt to make changes
puts "Your virtual golf bag:"
clubs_printer(virtual_bag)
# puts "Do you need to make any changes? y/n"
# change = gets.chomp
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

# ask questions about the shot and call corresponding method
puts "What is your distance to target?"
yardage = gets.chomp.to_f

puts "What is the temperature today?"
temp = temperature(gets.chomp.to_f)

puts "What is the elevation change to your target?"
elevate = elevation(gets.chomp.to_f, yardage)

puts "How strong is the wind in mph?"
mph = gets.chomp.to_f

puts "What direction is it blowing? In your face (f), at your back (b), diagonally in your face (df), or diagonally in your back (db)?"
direction = gets.chomp
windy = wind(mph, yardage, direction)

puts "If you are on a hill, enter uphill (u) or downhill (d).  Enter (e) if even lie."
hill = slope(gets.chomp)

puts "If you are in the rough, enter sitting up (s), partially buried (p), or buried (b).  Enter (n) for not in rough."
ruff = rough(gets.chomp)

puts "Is it raining or very wet? y/n"
wet = rain(gets.chomp)

puts "Are you in a bunker? y/n"
sand = bunker(gets.chomp)

# combine all the yard adjustment methods
adjusted_yardage = yardage + temp + elevate + windy + hill + wet + sand
p adjusted_yardage
# account for if in the rough and how buried ball is
rough_adjuster = adjusted_yardage + (adjusted_yardage * ruff)
p rough_adjuster
# drop yardage to the nearest 10th. ie 164 to 160
adjust_to_tens = ((rough_adjuster/10).floor * 10)
p adjust_to_tens

