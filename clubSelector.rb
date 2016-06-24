###### METHODS

# Temperature method - for every 1 degree below 70 degrees: add .35yds
def temperature(degrees)
	if degrees < 70.0
		temp_change = ((70.0 - degrees) * 0.35)
	else
		temp_change = 0
	end
	temp_change
end

# Elevation method - for every 1ft above: add .5yds >150 yards, .25yds 150-130 yards, .1yds <130 yards
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

# Wind method - for every 1mph in face: add 1yd >200 yards, add .75yrds 200-100 yards, .5yds <100 yards
#               reverse for in the back
#               for every 1mph diag in face: add/aim .5yd >200 yards, add/aim .37yds 200-100 yards, add/aim .25yds <100 yards
#               reverse for diag in the back
#               use in face and in back calculations for sideways wind
def wind(mph, yardage, direction)
	if direction == "f"
		puts "forward"
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

# Stance method - if uphill: add 10yds aim 3yds right - ball forward, if downhill: minus 10yds aim 3yds left - ball backward
#                 if above ball: aim body 5yds left >150 yards and 10yds <150 yards - choke down
#                 reverse for below ball - choke up
def uneven_lie(stance)
	if stance == "u"
		stance_change = 10.0
	elsif stance == "d"
		stance_change = -10.0
	else 
		stance_change = 0
	end
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
end

# Rain method - if yes, add 10yds
def rain(is_raining)
	if is_raining == "y"
		rain_change = 10
	else
		rain_change = 0
	end
end

# Fairway bunker method - if yes, add 10yds
def bunker(in_sand)
	if in_sand == "y"
		bunker_change = 10
	else
		bunker_change = 0
	end
end
# Set variables for yardage, aim, ball in stance, and hand placement.  Yardage will be a prompt



###### DRIVER TESTS


yardage = 155.0
aim = 0
ball_in_stance = "normal"
hands = "normal"

temp = temperature(71.0)
elev = elevation(-15.0, yardage)
windy = wind(15.0, yardage, "db")
lie = uneven_lie("e")
ruff = rough("n")
#adjust = yardage + temp + elev + windy + lie
#adjust_rough = adjust + (adjust * ruff)
#puts "Adjusted yardage is: #{adjust_rough}"
p windy


####### USER INTERFACE


