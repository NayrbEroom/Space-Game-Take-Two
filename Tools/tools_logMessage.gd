extends Node2D

@export var toggle: bool = false

var log_file = "res://log.txt"


func _ready():
	if toggle: 
		var file = FileAccess.open(log_file, FileAccess.READ_WRITE)
		if file == null:
			file = FileAccess.open(log_file, FileAccess.WRITE)
			file.store_string("------ New Session ------\n")
		else:
			file.store_string("\n------ New Session ------\n")
		file = null  # This will close the file
	#BUG: current bug that is not logging New Session on new iteration of game window not immediately an issue

func log_message(message):
	if toggle:
		var timestamp = Time.get_ticks_msec()
		var file = FileAccess.open(log_file, FileAccess.READ_WRITE)
		file.seek_end()
		file.store_string("Tick time: [" + str(timestamp) + "] " + message + "\n")
		file = null  # This will close the file

func log_node(node, indent=0):
	var indent_spaces = " ".repeat(indent)

	log_message(indent_spaces + node.name + " (" + node.get_class() + ")")

	var metadata = node.get_meta_list()
	for meta in metadata:
		log_message(indent_spaces + "meta " + meta + ": " + str(node.get_meta(meta)))

	if node.get_child_count() > 0:
		for i in range(node.get_child_count()):
			log_node(node.get_child(i), indent + 2)



