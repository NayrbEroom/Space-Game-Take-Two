extends Node2D

@export var debug: bool = false
@export var radiusHalfSize: float
@export var posXHalfSize: float
var posYHalfSize = posXHalfSize

@onready var timeKeeper = get_node("/root/Main/Time Keeper")

var Planet = preload("res://Classes/Planet.gd")
#var PlanetSprite = preload("res://")

var propertyMap = {
	"mass_kg": "Mass (kg)",
	"diameter_km": "Diameter (km)",
	"density_kg_m3": "Density (kg/m3)",
	"gravity_m_s2": "Gravity (m/s2)",
	"escape_velocity_km_s": "Escape Velocity (km/s)",
	"rotation_period_hours": "Rotation Period (hours)",
	"length_of_day_hours": "Length of Day (hours)",
	"distance_from_sun_km": "Distance from Sun (km)",
	"perihelion_km": "Perihelion (km)",
	"aphelion_km": "Aphelion (km)",
	"orbital_period_days": "Orbital Period (days)",
	"orbital_velocity_km_s": "Orbital Velocity (km/s)",
	"orbital_inclination_degrees": "Orbital Inclination (degrees)",
	"orbital_eccentricity": "Orbital Eccentricity",
	"obliquity_to_orbit_degrees": "Obliquity to Orbit (degrees)",
	"mean_temperature_celsius": "Mean Temperature (C)",
	"surface_pressure_bars": "Surface Pressure (bars)",
	"number_of_moons": "Number of Moons",
	"ring_system": "Ring System",
	"global_magnetic_field": "Global Magnetic Field"
}
# Called when the node enters the scene tree for the first time.
func _ready():
	var planet = Planet.new()
	if debug:
		if timeKeeper:
			print("Time Keeper found")
			print(timeKeeper.time)
	var planetInput = FileReader.read_file("res://sol_planets.json")
	for planetName in planetInput:
		var planetData = planetInput[planetName]
		
		#object creation
		planet.name = planetName
		#object location
		var planetXPosition = planetData["Distance from Sun (km)"]
		#BUG: orbit_radius not defined
		planet.orbit_radius = planetXPosition / posXHalfSize
		#TODO: position.y implementation need to implement time function first
		#var timeKeeper = get_node("/root/Main/Time Keeper")
		planet.position.y = 0
		
		#sprite creation
		var sprite = createSprite("res://Graphics/—Pngtree—blue solid color round_5487770.png", planetName)
		planet.add_child(sprite)
		#sprite scaling
		var radius = planetData["Diameter (km)"]
		var scale_factor = Vector2(radius, radius) / radiusHalfSize
		#TODO: provide better scaling mechanics for the image scaling 
		#this is seperate to the whole solar system object scaling
		sprite.scale *= scale_factor
		
		#tree manipulation
		self.add_child(planet)
		Logger.log_node(get_tree().root)
		
		#rest
		if debug: 
			print("Planet name: " + str(planet.name))
			print("Planet position: " + str(planet.position))
			print("Planet sprite scale: " + str(sprite.scale))
			print("=====================")
			
	#log exports node tree
	#Logger.log_node(get_tree().root)

func createObject(ObjectClass, objectData):
	print(ObjectClass)
	var newObject = ObjectClass.new()
	for property in propertyMap.keys():
		var key = propertyMap[property]
		var value = objectData[key]
		# Special handling for boolean values
		if property == "ring_system" or property == "global_magnetic_field":
			value = value == "Yes"
		newObject.set(property, value)
		#BUG: orbit_angle not defined
	newObject.orbit_angle = 0.0
	return newObject

func createSprite(imagePath, name):
	var sprite = Sprite2D.new()
	sprite.texture = load(imagePath)
	sprite.name = name + " Sprite"
	#sprite is returned as an object
	return sprite




