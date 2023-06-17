extends Node

func read_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var json_text = file.get_as_text()
	file = null  # This will close the file as per Godot 4.0 documentation
	
	var json = JSON.new()
	var data = json.parse(json_text)
	if data == OK:
		var data_received = json.data
		return data_received
	else:
		return null
		
		
