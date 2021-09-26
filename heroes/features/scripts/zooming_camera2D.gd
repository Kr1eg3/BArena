extends Camera2D

export var min_zoom := 0.5
export var max_zoom := 2.0
export var zoom_factor := 0.1
export var zoom_duration := 0.2

var _zoom_level := 1.0 setget _set_zoom_level

onready var tween: Tween = $Tween

func _set_zoom_level(value: float) -> void:
	_zoom_level = clamp(value, min_zoom, max_zoom)
	
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(_zoom_level, _zoom_level),
		zoom_duration,
		tween.TRANS_SINE,
		tween.EASE_OUT
	)	
	tween.start()

func _unhandled_input(event):
	if event.is_action_pressed("ui_zoom_in"):
		_set_zoom_level(_zoom_level - zoom_factor)
	if event.is_action_pressed("ui_zoom_out"):
		_set_zoom_level(_zoom_level + zoom_factor)
