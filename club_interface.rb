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
		CREATE TABLE IF NOT EXISTS clubs (
			name VARCHAR(255),
			dist_yards INT
		)
	SQL
db.execute(clubs_table)


# club_enter = ""
# until club_enter == "d"
# 	puts "Enter a club or type 'd' if finished"
# 	club = gets.chomp
# 	puts "Enter the distance (only use yardage to the nearest 10s. ex - 130, 160, etc."
# 	dist = gets.chomp

	



# yardage = 88.0
# aim = 0
# ball_in_stance = "normal"
# hands = "normal"

# temp = temperature(76.0)
# elev = elevation(0, yardage)
# windy = wind(5.0, yardage, "f")
# lie = uneven_lie("n")
# ruff = rough("n")
# rain = rain("n")
# bunker = bunker("y")
# adjust = yardage + temp + elev + windy + lie + rain + bunker
# p adjust
# adjust_rough = adjust + (adjust * ruff)
# puts "Adjusted yardage is: #{adjust_rough}"

#p bunker

## PSUEDOCODE INTERFACE .....

# ask if user is new or existing

# if new, prompt for name and all clubs/distances and 
# add into new database

# if existing, ask for name (this will reference DB)

