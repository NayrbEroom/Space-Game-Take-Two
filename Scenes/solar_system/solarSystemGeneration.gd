extends Node2D

#exports
@export var debug: bool = false
@export var xScale: float = 200000.0
@export var yScale: float = 200000.0


#inmports
@onready var timeKeeper = $"../Time Keeper"
@onready var globalDate = Global.globalDate
@onready var Planet = preload("res://Classes/Planet.gd")
@onready var planetContainer = $"Orbitals/Planet Container"

func _ready():
	initPlanets()
	initMoons()
	initAsteroids()
	

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
		
		
		#init position 
		#TODO: need to devise scale the init x position and the iterated positions should be halved by that scale
		currentPlanet.position.x = floor(currentPlanet.distance_from_sun / xScale)
		print(currentPlanet.position.x )
		#TODO: the init Y position should be based off the DateObjects current date and the planets orbital period
		
		
		#fin
		planetContainer.add_child(currentPlanet)
	
		
		
		
		#getPlanetPosition(currentPlanet.perihelion, currentPlanet.aphelion, currentPlanet.orbital_period, currentPlanet.orbital_eccentricity, currentPlanet.orbital_inclination, globalDate.get)


		#init location
		#var planetLocation = Vector2(currentPlanet.distance_from_sun,0)
func initMoons():
	pass
func initAsteroids():
	pass










