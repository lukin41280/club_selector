require_relative "club_methods"

yardage = 88.0
aim = 0
ball_in_stance = "normal"
hands = "normal"

temp = temperature(76.0)
elev = elevation(0, yardage)
windy = wind(5.0, yardage, "f")
lie = uneven_lie("n")
ruff = rough("n")
rain = rain("n")
bunker = bunker("y")
adjust = yardage + temp + elev + windy + lie + rain + bunker
p adjust
adjust_rough = adjust + (adjust * ruff)
puts "Adjusted yardage is: #{adjust_rough}"

#p bunker

## PSUEDOCODE INTERFACE .....