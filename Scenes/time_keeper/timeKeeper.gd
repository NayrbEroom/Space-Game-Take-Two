extends Node

@export var debug: bool = false
@export var time: float = 0.0

@onready var planetContainer = get_node("/root/Main/Solar System/Orbitals/Planet Container")

var myDate: DateObject = null

#need function to set initial time 
#TODO: this will eventually need to be connected to something the User can set when creating game
func _ready():
	myDate = DateObject.new(26, 12, 2023)
	myDate.printDate()


func advanceTime(amount):
	time += amount
	movePlanets(amount)
	myDate.advanceDay(amount)
	myDate.printDate()

func movePlanets(amount):
	for planet in planetContainer.get_children():
		var newPosition = Vector2()
		planet.orbit_angle += amount
		newPosition.x = planet.orbit_radius * cos(planet.orbit_angle)
		newPosition.y = planet.orbit_radius * sin(planet.orbit_angle)
		planet.position = newPosition
		if debug:
			print(planet.position)

func _on_play_button_pressed():
	if debug:
		print("Pressed")
	advanceTime(1)
