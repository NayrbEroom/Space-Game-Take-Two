extends Node2D


@export var debug: bool = false

var scale_factor = Vector2(0.1, 0.1)


func _ready():
	scaleChildren(self)

func scaleChildren(node):
	if node is Node2D:
		node.scale *= scale_factor
		if debug:
			print(node.name)
	for child in node.get_children():
		scaleChildren(child)
