extends Node2D

@export var debug: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if debug:
		print_tree_pretty()


