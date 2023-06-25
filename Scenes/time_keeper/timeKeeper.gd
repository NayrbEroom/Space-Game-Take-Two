extends Node

@export var debug: bool = false
@export var currentTime: float = 0.0

@onready var planetContainer = get_node("/root/Main/Solar System/Orbitals/Planet Container")


#TODO: this will eventually need to be connected to something the User can set when creating game


#-------------------------------------------------------------
#need function to set initial date 
func _ready():
	Global.globalDate = DateObject.new(1, 1, 2000, 0)
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

func _on_five_day_pressed():
	advanceTime(432000)
