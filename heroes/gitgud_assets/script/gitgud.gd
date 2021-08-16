extends KinematicBody2D


var _hero_max_speed = 150
var _hero_speed = 0
var _hero_accel = 200
var move_direction
var moving = false
var destination = Vector2()
var movement = Vector2()


onready var _animated_sprite = $AnimatedSprite
	

func _unhandled_input(event):
	if event.is_action_pressed('right_click'):
		moving = true
		destination = get_global_mouse_position()

func _movement_loop(delta):
	if moving == false:
		_hero_speed = 0
	else:
		_hero_speed += _hero_accel * delta
		if _hero_speed > _hero_max_speed:
			_hero_speed = _hero_max_speed
	movement = position.direction_to(destination) * _hero_speed
	move_direction = rad2deg(destination.angle_to_point(position))
	if position.distance_to(destination) > 5:
		movement = move_and_slide(movement)
	else:
		moving = false

func _animation_loop():
	var anim_direction = "s"
	var anim_mode = "idle"
	var animation
	if move_direction <= 15 and move_direction >= -15:
		anim_direction = "e"
	elif move_direction <= 60 and move_direction >= 15:
		anim_direction = "se"
	elif move_direction <= 120 and move_direction >= 60:
		anim_direction = "s"
	elif move_direction <= 165 and move_direction >= 120:
		anim_direction = "sw"
	elif move_direction >= -60 and move_direction <= -15:
		anim_direction = "ne"
	elif move_direction >= -120 and move_direction <= -60:
		anim_direction = "n"
	elif move_direction >= -165 and move_direction <= -120:
		anim_direction = "nw"
	elif move_direction <= -165 or move_direction >= 165:
		anim_direction = "w"

	if moving == true:
		anim_mode = "jump"
	elif moving == false:
		anim_mode = "idle"
	animation = anim_mode + "_" + anim_direction
	_animated_sprite.play(animation)

func _physics_process(delta):
	_movement_loop(delta)

func _process(delta):
	_animation_loop()


