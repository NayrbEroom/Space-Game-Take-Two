extends Node2D

@export var debug: bool = false
@export var radiusHalfSize: float
@export var posXHalfSize: float
var posYHalfSize = posXHalfSize

@onready var timeKeeper = get_node("/root/Main/Time Keeper")

var Planet = preload("res://Classes/Planet.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	var planetInput = FileReader.read_file("res://sol_planets.json")


	for planetName in planetInput:
		var planet = Planet.new()  # Create a new instance of the Planet class
		var data = planetInput[planetName]  # Get the data for this planet from the JSON file

		# Set the properties of the planet instance
		planet.name = planetName
		planet.mass_kg = data["Mass (kg)"]
		planet.diameter_km = data["Diameter (km)"]
		planet.density_kg_m3 = data["Density (kg/m3)"]
		planet.gravity_m_s2 = data["Gravity (m/s2)"]
		planet.escape_velocity_km_s = data["Escape Velocity (km/s)"]
		planet.rotation_period_hours = data["Rotation Period (hours)"]
		planet.length_of_day_hours = data["Length of Day (hours)"]
		planet.distance_from_sun_km = data["Distance from Sun (km)"]
		planet.perihelion_km = data["Perihelion (km)"]
		planet.aphelion_km = data["Aphelion (km)"]
		planet.orbital_period_days = data["Orbital Period (days)"]
		planet.orbital_velocity_km_s = data["Orbital Velocity (km/s)"]
		planet.orbital_inclination_degrees = data["Orbital Inclination (degrees)"]
		planet.orbital_eccentricity = data["Orbital Eccentricity"]
		planet.obliquity_to_orbit_degrees = data["Obliquity to Orbit (degrees)"]
		planet.mean_temperature_celsius = data["Mean Temperature (C)"]
		planet.surface_pressure_bars = data["Surface Pressure (bars)"]
		planet.number_of_moons = data["Number of Moons"]
		planet.ring_system = data["Ring System"] == "Yes"
		planet.global_magnetic_field = data["Global Magnetic Field"] == "Yes"

		# object location
		var planetXPosition = data["Distance from Sun (km)"]
		planet.orbit_radius = planetXPosition / posXHalfSize

		# Calculate the position of the planet
		var angle = randf_range(0, 2 * PI)  # Random angle in radians
		planet.position.x = planet.orbit_radius * cos(angle)
		planet.position.y = planet.orbit_radius * sin(angle)

		# sprite creation
		var sprite = createSprite("res://Graphics/—Pngtree—blue solid color round_5487770.png", planetName)
		planet.add_child(sprite)

		# sprite scaling
		var radius = data["Diameter (km)"]
		var scale_factor = Vector2(radius, radius) / radiusHalfSize
		sprite.scale *= scale_factor
		
		# tree manipulation
		self.add_child(planet)
		Logger.log_node(get_tree().root)

		# fin
		if debug: 
			print("Planet name: " + str(planet.name))
			print("Planet position: " + str(planet.position))
			print("Planet sprite scale: " + str(sprite.scale))
			print("=====================")

func createSprite(imagePath, name):
	var sprite = Sprite2D.new()
	sprite.texture = load(imagePath)
	sprite.name = name + " Sprite"
	#sprite is returned as an object
	return sprite




