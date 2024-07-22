extends Camera2D
var dragging: bool = false
var drag_start: Vector2
var initial_camera_pos: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()

func _input(event: InputEvent):
	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			drag_start = event.position
			initial_camera_pos = position
		else:
			dragging = false
	elif event is InputEventScreenDrag and dragging:
		var drag_vector = event.position - drag_start
		position = initial_camera_pos - drag_vector

func _unhandled_input(event: InputEvent):
	_input(event)
