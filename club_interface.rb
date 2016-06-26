# this is a project that i plan to continue to work on:
# program that will provide a golfer what club they should use depending upon 
# multiple factors affecting their shot such as wind, slope, and temperature.
# methods are created to adjust the yardage the golfer will have to account 
# from their imputs.  the golfer will need to set up the distances upfront
# on how far they hit each club and this will be stored into a database titled 
# as their name. once the questions regarding the shot conditions are answered,
# the program will print the club to use based off the adjusted yardage. 

# i am trying to work out setting up clubs to have a range of yardage.  until
# then, all clubs will have one value at what I am calling the "nearest 10th".
# i will then round the adjusted yardage to nearest 10th. ex. adj yards is 167.3,
# will round to 170.  adj yards is 142.89, will round to 140.  this will allow
# the code to provide a matched club from the database as long as that yaradge
# was entered.

# WORK IN PROGRESS:
# 1) program only works setting up the database entirely everytime. would like
#    to have program access existing database so returning users dont have to 
#    keep adding clubs and distances
# 2) would like to have user be able to make changes to their existing clubs
#    database or immediately when they create their first one
# 3) have a range of distances for each club. idea: whatever is entered, set a
#    range of values.  min will be user entry minus 5 and max will be add 4 to
#    user entry to give a range of 10 yards.  this will provide more accurate
#    results

require_relative "club_methods"
require "SQLite3"

# setting up golfer's clubs database
# Apply WIP #1 around here
puts "What is your name?"
name = gets.chomp
db = SQLite3::Database.new("#{name}.db")
db.results_as_hash = true

# create table to hold user entered clubs
clubs_table = <<-SQL
		CREATE TABLE IF NOT EXISTS virtual_bag (
			club_name VARCHAR(255),
			dist_yards INT
		)
	SQL
db.execute(clubs_table)

# have user add clubs and distances to the club table
club = ""
until club == "d"
	puts "Enter a club or type 'd' if finished"
	club = gets.chomp
	if club == "d"
		puts "**Virtual golf bag completed**"
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

# ----------------------------
# Apply WIP #2

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
#-----------------------------

# ask questions about the shot and call corresponding method
puts "What is your distance to target?"
yardage = gets.chomp.to_f

puts "What is the temperature today?"
temp = temperature(gets.chomp.to_f)

puts "What is the elevation change to your target? Use (-) if above target."
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
# round yardage to the nearest 10th
adjust_to_tens = (((rough_adjuster + 5)/10).floor * 10)
p adjust_to_tens

# find yardage in database and match to club to hit. provide to user
puts 
puts "Results are:"
puts

virtual_bag.size.times do |club|
	if virtual_bag[club]["dist_yards"] == adjust_to_tens
	puts "You should use your #{virtual_bag[club]["club_name"]}"
	end
end
puts "Play this shot for adjusted yardage of #{adjust_to_tens}"
puts "NOTE: No club is given if there is no yardage match"

