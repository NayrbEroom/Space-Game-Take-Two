extends Node2D

#exports
@export var debug: bool = false
@export var xScale: float = 1000000.0
@export var yScale: float = 500000.0


#inmports
@onready var timeKeeper = $"../Time Keeper"
@onready var globalDate = Global.globalDate
@onready var Planet = preload("res://Classes/Planet.gd")
@onready var planetContainer = $"Orbitals/Planet Container"
@onready var lastUpdatedDay = 0

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
		#TODO: the init Y position should be based off the DateObjects current date and the planets orbital period


		#init sprite
		#TODO: I have to fix the scaling right now it is way too rigid
		var additionalScaleFactor = 0.0001
		var scalePower = 0.5
		var sprite = createSprite("res://Graphics/—Pngtree—blue solid color round_5487770.png", planetName)
		currentPlanet.add_child(sprite)
		var radius = data["Diameter"]
		var scaleFactor = Vector2(pow(radius, scalePower), pow(radius, scalePower)) * additionalScaleFactor
		sprite.scale *= scaleFactor
		
		#init planet description UI
		
		
		#fin
		planetContainer.add_child(currentPlanet)
	
		
		
		
		#getPlanetPosition(currentPlanet.perihelion, currentPlanet.aphelion, currentPlanet.orbital_period, currentPlanet.orbital_eccentricity, currentPlanet.orbital_inclination, globalDate.get)


		#init location
		#var planetLocation = Vector2(currentPlanet.distance_from_sun,0)

func createSprite(imagePath, spriteName):
	var sprite = Sprite2D.new()
	sprite.texture = load(imagePath)
	sprite.name = spriteName + " Sprite"
	#sprite is returned as an object
	return sprite

func initMoons():
	pass
func initAsteroids():
	pass

func rotateSolarSystem():
	# get current day
	var currentDay = globalDate.getDayOfYear()
	# if the day has not changed since the last update, do nothing
	if currentDay < lastUpdatedDay:
		lastUpdatedDay = 0
	elif currentDay == lastUpdatedDay:
		return

	# otherwise, update lastUpdatedDay and continue with the update
	lastUpdatedDay = currentDay

	# update each planet's position based on the current day
	for planet in planetContainer.get_children():
		var orbitalFraction = float(currentDay) / planet.orbital_period
		var angle = 2 * PI * orbitalFraction

		# assuming the orbit is a circle centered at the origin
		var scaled_distance_from_sun = floor(planet.distance_from_sun) / xScale
		planet.position.x = floor(scaled_distance_from_sun * cos(angle))
		planet.position.y = floor(scaled_distance_from_sun * sin(angle))
		#BUG: large jump happens at end of year I think it has to do with roundings I am doing but will bug test later functional partially right now moving on to more fun things. This is a major problem for the planets that never reach a full cycle by end of year (like neptune or something that takes longer than a year to go around the sun
		if debug:
			print("=============")
			print(planet.name)
			print(planet.position.x)
			print("-----------")
			globalDate.printDate()
			print("=============")
			print(planet.name)
			print(planet.position.x)
			print(planet.position.y)
