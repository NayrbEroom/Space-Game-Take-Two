extends Camera2D

@export var debug: bool = false
@export var panSpeed: float
@export var zoomIncrement: float


var isDragging = false
var dragStart = Vector2()

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
			dragStart = get_local_mouse_position()
			isDragging = true
			if debug:
				print("Right button pressed, dragging started at position " + str(dragStart))
		elif event.button_index == MOUSE_BUTTON_RIGHT and not event.is_pressed():
			isDragging = false
			if debug:
				print("Right button released, dragging stopped")
	elif event is InputEventMouseMotion and isDragging:
		var dragEnd = get_local_mouse_position()
		var dragDifference = dragStart - dragEnd
		position += dragDifference
		dragStart = dragEnd
		if debug:
			print("Mouse motion detected while dragging, position updated to " + str(position))


func _process(delta):
#	print("Input process initialized")
	if Input.is_action_pressed("ui_up"):
		if Input.is_action_pressed("ui_shift"):
			position.y -= (panSpeed * 4)
			if debug:
				print("Shift + Up detected, position y decreased by " + str((panSpeed * 4)))
		else:
			position.y -= panSpeed
			if debug:
				print("Up detected, position y decreased by " + str(panSpeed))
				print(panSpeed	)
	if Input.is_action_pressed("ui_down"):
		if Input.is_action_pressed("ui_shift"):
			position.y += (panSpeed * 4)
			if debug:
				print("Shift + Down detected, position y increased by " + str((panSpeed * 4)))
				print(panSpeed	)
		else:
			position.y += panSpeed
			if debug:
				print("Down detected, position y increased by " + str(panSpeed))
				print(panSpeed	)
	if Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("ui_shift"):
			position.x -= (panSpeed * 4)
			if debug:
				print("Shift + Left detected, position x decreased by " + str((panSpeed * 4)))
				print(panSpeed	)
		else:
			position.x -= panSpeed
			if debug:
				print("Left detected, position x decreased by " + str(panSpeed))
				print(panSpeed	)
	if Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("ui_shift"):
			position.x += (panSpeed * 4)
			if debug:
				print("Shift + Right detected, position x increased by " + str((panSpeed * 4)))
				print(panSpeed	)
		else:
			position.x += panSpeed		
			if debug:	
				print("Right detected, position x increased by " + str(panSpeed))
				print(delta)
	if Input.is_action_pressed("ui_zoom_in"):
		if debug:
			print("Zoom in detected, zoom increased by " + str(zoomIncrement))
			print(zoom)
		zoom.x += zoomIncrement
		zoom.y += zoomIncrement
		
	if Input.is_action_pressed("ui_zoom_out"):
		if get_zoom() == Vector2(1, 1):
			return
		else:
			if debug:
				print("Zoom out detected, zoom decreased by " + str(zoomIncrement))
				print(zoom)
			zoom.x -= zoomIncrement
			zoom.y -= zoomIncrement
			
				
	#TODO: ["FINISHED"] add button to reset position
	#TODO: ["FINISHED"] add button to reset zoom
	if Input.is_action_pressed("ui_home"):
		position = Vector2(0, 0)
		zoom = Vector2(1, 1)
	
		#BUG: fix bug with pressing button repeating 4 times with each single press
		#maybe take out of process and put in input?

		

		
		
		

		#BUG: fix mousewheel input not being registered in godot
			

