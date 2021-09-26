extends Node2D

var heroe = preload("res://heroes/gitgud.tscn")
var heroe_instance = heroe.instance()

onready var nav : Navigation2D = $Navigation2D

var path : PoolVector2Array
var goal : Vector2
export var speed := 250

func _unhandled_input(event):
	if event.is_action_pressed('right_click'):
		#goal = event.position
		goal = get_viewport_transform().affine_inverse().xform( event.position )
		path = nav.get_simple_path($Area2D/YSort_AllOfUs/gitgud.position, goal)
		$Line2D.points = PoolVector2Array(path)
		$Line2D.show()
		#print(path)

func _process(delta: float) -> void:
	if !path:
		$Line2D.hide()
		return
	if path.size() > 0:
		var d: float = $Area2D/YSort_AllOfUs/gitgud.position.distance_to(path[0])
		if d > 20:
			$Area2D/YSort_AllOfUs/gitgud.position = $Area2D/YSort_AllOfUs/gitgud.position.linear_interpolate(path[0], (speed * delta)/d)
		else:
			path.remove(0)
