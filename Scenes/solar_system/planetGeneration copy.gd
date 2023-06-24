extends Node2D

#exports
@export var debug: bool = false


#inmports
@onready var timeKeeper = get_node("../root/TimeKeeper")
@onready var globalDate = Global.globalDate
@onready var Planet = preload("res://Classes/Planet.gd")





func _ready():

	initPlanets()



#need to set start location based on timeKeeper date
func initPlanets():
	var planetInput = FileReader.read_file("res://sol_planets.json")

	for planetName in planetInput:
		var currentPlanet = Planet.new()
		var data = planetInput[planetName]

		currentPlanet.name = planetName
		currentPlanet.mass = str(data["Mass"])
		currentPlanet.distance_from_sun = data["Distance from Sun"]
		currentPlanet.orbital_period = data["Orbital Period"]
		currentPlanet.orbital_eccentricity = data["Orbital Eccentricity"]
		currentPlanet.orbital_inclination = data["Orbital Inclination"]
		currentPlanet.perihelion = data["Perihelion"]
		currentPlanet.aphelion = data["Aphelion"]

		getPlanetPosition(currentPlanet.perihelion, currentPlanet.aphelion, currentPlanet.orbital_period, currentPlanet.orbital_eccentricity, currentPlanet.orbital_inclination, globalDate.get)


		#init location
		var planetLocation = Vector2(currentPlanet.distance_from_sun,0)


func getPlanetPosition(perihelion: float, aphelion: float, orbital_period: float, orbital_eccentricity: float, orbital_inclination: float, current_time: float) -> Vector2:
	var a = (perihelion + aphelion) / 2
	var b = a * sqrt(1 - pow(orbital_eccentricity, 2))
	var theta = 2 * PI * current_time / orbital_period
	var x = a * cos(theta)
	var y = b * sin(theta)
	var x_prime = x * cos(orbital_inclination) - y * sin(orbital_inclination)
	var y_prime = x * sin(orbital_inclination) + y * cos(orbital_inclination)
	return Vector2(x_prime, y_prime)









