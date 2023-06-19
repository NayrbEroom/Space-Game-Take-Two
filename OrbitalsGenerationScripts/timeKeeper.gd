extends Node

@export var debug: bool = false
@export var time: float = 0.0

@onready var planetContainer = get_node("/root/Main/Solar System/Orbitals/Planet Container")


func advanceTime(amount):
	time += amount
	movePlanets(amount)

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
	print("Pressed")
	advanceTime(1)
