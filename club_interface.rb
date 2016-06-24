require_relative "club_selector"

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