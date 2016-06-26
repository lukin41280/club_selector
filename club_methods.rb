###### METHODS
# Based on researching golf strategies, there are baseline adjustments to make when
# making golf shots when conditions and lies are not ideal.  The methods below are 
# the adjustments to make how much further or shorter a golfer should look to hit a
# shot.  These are merely a concensus of opinions and serve as a baseline.

# Methods are kept seperate, even in the event of repeated code to allow user to 
# update specific changes if they are warranted.


# Temperature method - for every 1 degree below 70 degrees: add .35yds
def temperature(degrees)
	if degrees < 70.0
		temp_change = ((70.0 - degrees) * 0.35)
	else
		temp_change = 0
	end
	temp_change
end

# Elevation method - for every 1ft above/below target: (+/-) .5yds >150 yards out, 
# (+/-) .25yds 150-130 yards out, (+/-) .1yds <130 yards out
def elevation(feet, yardage)
	if yardage > 150.0
		elevate_change = feet * 0.5
	elsif yardage <= 150.0 && yardage >= 130.0
		elevate_change = feet * 0.25
	elsif yardage < 130.0
		elevate_change = feet * 0.13
	end
	elevate_change
end

# Wind method - for every 1mph in the face: add 1yd >200 yards out, 
# add .75yrds 200-100 yards out, .5yds <100 yards out
# subtract yardage for wind in the back
# for diagonal wind in the face: add amounts above, but take half the values
# subtract half the values for wind diagonally in the back
def wind(mph, yardage, direction)
	if direction == "f"
		if yardage > 200.0
			wind_change = mph 
		elsif yardage <= 200.0 && yardage >= 100.0
			wind_change = mph * 0.75
		elsif yardage < 100.00
			wind_change = mph * 0.50
		end
	end
	if direction == "b"
		if yardage > 200.0
			wind_change = -(mph) 
		elsif yardage <= 200.0 && yardage >= 100.0
			wind_change = -(mph) * 0.75
		elsif yardage < 100.00
			wind_change = -(mph) * 0.50
		end
	end
	if direction == "df"
		if yardage > 200.0
			wind_change = (mph)/2
		elsif yardage <= 200.0 && yardage >= 100.0
			wind_change = ((mph) * 0.75)/2
		elsif yardage < 100.00
			wind_change = ((mph) * 0.50)/2
		end
	end
	if direction == "db"
		if yardage > 200.0
			wind_change = -(mph)/2
		elsif yardage <= 200.0 && yardage >= 100.0
			wind_change = -((mph) * 0.75)/2
		elsif yardage < 100.00
			wind_change = -((mph) * 0.50)/2
		end
	end
	wind_change
end

# Slope method - if hitting uphill add 10yds, if hitting downhill minus 10yds
def slope(hill_type)
	if hill_type == "u"
		slope_change = 10.0
	elsif hill_type == "d"
		slope_change = -10.0
	else 
		slope_change = 0
	end
	slope_change
end


# Rough method - for sitting up: add 5% to total yds, for 25% buried: add 10% to total yds, for half ball: add 20% to total 
def rough(depth)
	if depth == "s"
		rough_change = 0.05
	elsif depth == "p"
		rough_change = 0.10
	elsif depth == "b"
		rough_change = 0.20
	else
		rough_change = 0
	end
	rough_change
end

# Rain method - if yes, add 10yds
def rain(is_raining)
	if is_raining == "y"
		rain_change = 10
	else
		rain_change = 0
	end
	rain_change
end

# Fairway bunker method - if yes, add 10yds
def bunker(in_sand)
	if in_sand == "y"
		bunker_change = 10
	else
		bunker_change = 0
	end
	bunker_change
end


#SQL Method --------

# Print clubs listed in vitrual golf bag
def clubs_printer(db_table)
	db_table.size.times do |club|
		puts "#{db_table[club]["club_name"]} averages #{db_table[club]["dist_yards"]} yards" 
	end
end


