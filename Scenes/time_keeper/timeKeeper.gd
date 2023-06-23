extends Node

@export var debug: bool = false
@export var time: float = 0.0

@onready var planetContainer = get_node("/root/Main/Solar System/Orbitals/Planet Container")

#need function to set initial time 
#TODO: this will eventually need to be connected to something the User can set when creating game

func _ready(): 
	Global.globalDate = DateObject.new(26, 12, 2023)
	Global.globalDate.printDate()
	
	
func advanceTime(amount):
	time += amount
	movePlanets(amount)
	Global.globalDate.advanceDay(amount)
	Global.globalDate.printDate()

func movePlanets(amount):
	for planet in planetContainer.get_children():
		var newPosition = Vector2()
		var daysPassed = Global.globalDate.getDay() + Global.globalDate.getMonth() * 30 + Global.globalDate.getYear() * 365
		var angle = (daysPassed * 2 * PI) / planet.orbital_period_days  # Calculate a different angle for each planet
		planet.orbit_angle += angle  # Add the calculated angle to the planet's orbit_angle
		newPosition.x = planet.orbit_radius * cos(planet.orbit_angle)
		newPosition.y = planet.orbit_radius * sin(planet.orbit_angle)
		planet.position = newPosition
		if debug:
			print(planet.position)


func _on_play_button_pressed():
	if debug:
		print("Pressed")
	advanceTime(1)
