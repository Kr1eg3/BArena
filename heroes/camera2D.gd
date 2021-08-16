extends Camera2D

var _camera_speed = 10
var _camera_accel = 100

onready var uncur = false



func _checkcur():
	if Input.is_action_pressed("ui_fixed_cam"):
		if uncur == false:
			uncur = true
		else:
			uncur = false

func _process(delta):
	_checkcur()
	
	if uncur == true:
		current = false
	else:
		current = true

		
