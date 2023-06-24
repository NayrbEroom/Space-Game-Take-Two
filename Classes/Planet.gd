extends Node2D

class_name Planet 

var mass: String #kg
var diameter: float #km
var density: float #kg/m^3
var gravity: float #m/s^2
var escape_velocity: float #km/s
var rotation_period: float #hours
var length_of_day: float #hours
var distance_from_sun: int #km
var perihelion: int #km
var aphelion: int #km
var orbital_period: float #days
var orbital_velocity: float #km/s
var orbital_inclination_degrees: float
var orbital_eccentricity: float
var obliquity_to_orbit_degrees: float
var mean_temperature: int #celsius
var surface_pressure: int #bars
var number_of_moons: int
var ring_system: bool
var global_magnetic_field: bool
var orbit_angle: float
var orbit_radius: int

func _init():
	mass = ""
	diameter = 0.0
	density = 0.0
	gravity = 0.0
	escape_velocity = 0.0
	rotation_period = 0.0
	length_of_day = 0.0
	distance_from_sun = 0
	perihelion = 0
	aphelion = 0
	orbital_period = 0.0
	orbital_velocity = 0.0
	orbital_inclination_degrees = 0.0
	orbital_eccentricity = 0.0
	obliquity_to_orbit_degrees = 0.0
	mean_temperature = 0
	surface_pressure = 0
	number_of_moons = 0
	ring_system = false
	global_magnetic_field = false
	orbit_angle = 0.0
	orbit_radius = 0
