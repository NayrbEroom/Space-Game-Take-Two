extends Node2D


var mass_kg: float
var diameter_km: float
var density_kg_m3: float
var gravity_m_s2: float
var escape_velocity_km_s: float
var rotation_period_hours: float
var length_of_day_hours: float
var distance_from_sun_km: int
var perihelion_km: int
var aphelion_km: int
var orbital_period_days: float
var orbital_velocity_km_s: float
var orbital_inclination_degrees: float
var orbital_eccentricity: float
var obliquity_to_orbit_degrees: float
var mean_temperature_celsius: int
var surface_pressure_bars: int
var number_of_moons: int
var ring_system: bool
var global_magnetic_field: bool
var orbit_angle: float = 0.0
var orbit_radius: int = 0

func _init():
	mass_kg = 0.0
	diameter_km = 0.0
	density_kg_m3 = 0.0
	gravity_m_s2 = 0.0
	escape_velocity_km_s = 0.0
	rotation_period_hours = 0.0
	length_of_day_hours = 0.0
	distance_from_sun_km = 0
	perihelion_km = 0
	aphelion_km = 0
	orbital_period_days = 0.0
	orbital_velocity_km_s = 0.0
	orbital_inclination_degrees = 0.0
	orbital_eccentricity = 0.0
	obliquity_to_orbit_degrees = 0.0
	mean_temperature_celsius = 0
	surface_pressure_bars = 0
	number_of_moons = 0
	ring_system = false
	global_magnetic_field = false
