# WORK IN PROGRESS:
# 1) DONE
# 2) DONE
# 3) have a range of distances for each club. idea: whatever is entered, set a
#    range of values.  min will be user entry minus 5 and max will be add 4 to
#    user entry to give a range of 10 yards.  this will provide more accurate
#    results
# 4) apply user prompt checks to make sure they are entering values correctly.
#    also to check that either a database exists or not if user answers "Are
#    you a returning user" incorrectly.  

require_relative "club_methods"
require "SQLite3"

# prompt if user is new or returning and either build or retreive database
db = nil
puts "Are you a returning user? y/n"
return_user = gets.chomp

if return_user == "n"
	puts "Welcome to Club Selector!  What is your name?"
	name = gets.chomp
	db = SQLite3::Database.new("#{name}.db")
	

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
else
	puts "Please enter your name."
	member = gets.chomp

	db = SQLite3::Database.open "#{member}.db"
	puts "Welcome back, #{member}!"
	puts
end
db.results_as_hash = true
virtual_bag = db.execute("SELECT * FROM virtual_bag")

# provide all clubs info and prompt to make changes
puts "Here is your virtual golf bag:"
clubs_printer(virtual_bag)
puts

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
		puts "Please select club to update"
		update_club = gets.chomp
		
		puts "Please update the average yardage to the nearest 10s"
		new_dist = gets.chomp
		
		db.execute("UPDATE virtual_bag SET dist_yards= ? WHERE club_name= ?", [new_dist, update_club])
		puts "Your #{update_club} was successfully updated."
		puts
	when "a"
		puts "Please name a new club to add."
		club_add = gets.chomp

		puts "Enter the average distance (only use yardage to the nearest 10s. ex - 130, 160, etc.)"
		dist_add = gets.chomp

		db.execute("INSERT INTO virtual_bag (club_name, dist_yards) VALUES (?,?)", [club_add, dist_add])
		puts "The #{club_add} was successfully added"
		puts
	when "d"
		puts "Which club would you like to delete?"
    	club_delete = gets.chomp
     	
     	db.execute("DELETE FROM virtual_bag WHERE club_name= ?", [club_delete])
     	puts "Your #{club_delete} was successfully deleted"
     	puts
	else
		puts "Incorrect response.  Please start again."
	end
	puts "Your updated virtual bag:"
	clubs_printer(virtual_bag)
	puts
end

# ask questions about the shot and call corresponding method
puts "Tell me about your upcomming shot.  Respond to some questions with letters in ()."
puts
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

puts "If your stance is on a hill, enter uphill (u) or downhill (d).  Enter (e) if even lie."
hill = slope(gets.chomp)

puts "If you are in the rough, enter sitting up (s), partially buried (p), or buried (b).  Enter (n) for not in rough."
ruff = rough(gets.chomp)

puts "Is it raining or very wet? y/n"
wet = rain(gets.chomp)

puts "Are you in a bunker? y/n"
sand = bunker(gets.chomp)

# combine all the yard adjustment methods
adjusted_yardage = yardage + temp + elevate + windy + hill + wet + sand
# account for if in the rough and how buried ball is
rough_adjuster = adjusted_yardage + (adjusted_yardage * ruff)
# round yardage to the nearest 10th
adjust_to_tens = (((rough_adjuster + 5)/10).floor * 10)

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

