extends Node

@export var debug: bool = false
@export var time: float = 0.0

@onready var planetContainer = get_node("/root/Main/Solar System/Orbitals/Planet Container")

#need function to set initial time 

func _ready(): 
	Global.globalDate = DateObject.new(1, 1, 2000)
	if debug:
		Global.globalDate.printDate()
	
	
func advanceTime(amount):
	time += amount
	movePlanets(amount)
	Global.globalDate.advanceDay(amount)
	Global.globalDate.printDate()

var lastDate = null  # Add this variable to store the date of the last update

func movePlanets(amount):
	var currentDate = Global.globalDate.getDay() + Global.globalDate.getMonth() * 30 + Global.globalDate.getYear() * 365
	var daysPassed = currentDate - lastDate if lastDate else 0
	lastDate = currentDate  # Update the lastDate variable

	for planet in planetContainer.get_children():
		var newPosition = Vector2()
		var angle = (daysPassed * 2 * PI) / planet.orbital_period_days  # Calculate a different angle for each planet
		planet.orbit_angle += angle  # Add the calculated angle to the planet's orbit_angle
		newPosition.x = planet.orbit_radius * cos(planet.orbit_angle)
		newPosition.y = planet.orbit_radius * sin(planet.orbit_angle)
		planet.position = newPosition
		if debug:
			print(planet.position)

#using an int for day (this would mean a second passes at lowest addition) calculation would give us a total play time of 292,277,265,436.27144820759791368779 years before stack overflow


#anything higher than a day is just going to be a multiple of days so if you want to add a year you would just add 365 days 
#this will be calculated on the button end. I will need to throw in an if to determin if month is feb or another non standard month can 
#use the daysInMonth function to do this
func calculateSeconds(value: int, type: String ) -> int:
	if type == "day":
		return value * 24 * 60 * 60
	elif type == "hour":
		return value * 60 * 60
	elif type == "minute":
		return value * 60





# buttons below
func _on_play_button_pressed():
	if debug:
		print("Pressed")
	advanceTime(1)
