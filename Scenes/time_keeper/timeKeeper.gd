extends Node

@export var debug: bool = false
@export var currentTime: float = 0.0

@onready var planetContainer = get_node("/root/Main/Solar System/Orbitals/Planet Container")
@onready var solarSystem = get_node("/root/Main/Solar System")


#TODO: this will eventually need to be connected to something the User can set when creating game


#-------------------------------------------------------------
#need function to set initial date 
func _ready():
	Global.globalDate = DateObject.new(12, 27, 2000, 0)
	if debug:
		Global.globalDate.printDate()

#need function to advance time
func advanceTime(amount: int) -> void:
	currentTime += amount
	
	# Update the date
	Global.globalDate.advanceSeconds(amount)
	
	if debug:
		Global.globalDate.printDate()


#-------------------------------------------------------------
# buttons below

func _on_one_day_pressed():
	advanceTime(86400)
	solarSystem.rotateSolarSystem()

func _on_five_day_pressed():
	advanceTime(432000)
	solarSystem.rotateSolarSystem()
	
func _on_three_month_pressed():
	advanceTime(7884000)
	solarSystem.rotateSolarSystem()
	
func _on_one_month_pressed():
	advanceTime(2628000)
	solarSystem.rotateSolarSystem()
	
func _on_six_month_pressed():
	advanceTime(15768000)
	solarSystem.rotateSolarSystem()

func _on_year_pressed():
	advanceTime(31536000)
	solarSystem.rotateSolarSystem()	
