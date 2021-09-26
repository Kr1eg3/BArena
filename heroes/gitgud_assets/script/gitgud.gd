extends KinematicBody2D


# Changeable Characteristics
var _hero_current_health = 500
var _hero_armor = 40
var _hero_atack_dmg = 30

# Unchangeable Characteristics
var _hero_max_speed = 150
var _hero_speed = 0
var _hero_accel = 200

var move_direction
var moving = false
var destination = Vector2()
var movement = Vector2()

var attacking = false
var attack_direction
var fire_direction
#spells 
 
var spell = preload("res://heroes/spells/Ice_Spear.tscn")
var can_fire = true
var rate_of_fire = 0.4


#end spells

#onready var _animated_sprite = $AnimatedSprite


func _unhandled_input(event):
	if event.is_action_pressed('right_click'):
		moving = true
		destination = get_global_mouse_position()
	elif event.is_action_pressed('left_click'):
		moving = false
		attacking = true
		attack_direction =rad2deg(get_angle_to(get_global_mouse_position()))
		_skill_loop()
	


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
	if moving:
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
	if  attacking == true:
		anim_mode = 'attack'
		if attack_direction <= 15 and attack_direction >= -15:
			anim_direction = "e"
		elif attack_direction <= 60 and attack_direction >= 15:
			anim_direction = "se"
		elif attack_direction <= 120 and attack_direction >= 60:
			anim_direction = "s"
		elif attack_direction <= 165 and attack_direction >= 120:
			anim_direction = "sw"
		elif attack_direction >= -60 and attack_direction <= -15:
			anim_direction = "ne"
		elif attack_direction >= -120 and attack_direction <= -60:
			anim_direction = "n"
		elif attack_direction >= -165 and attack_direction <= -120:
			anim_direction = "nw"
		elif attack_direction <= -165 or attack_direction >= 165:
			anim_direction = "w"
		
			
	animation = anim_mode + "_" + anim_direction
	get_node("AnimatedSprite").play(animation)


func _physics_process(delta):
	_movement_loop(delta)

func _process(delta):
	_animation_loop()
	_skill_loop()


func _skill_loop():
	if Input.is_action_pressed("left_click") and can_fire == true:
		can_fire = false
		attacking = true
		#_hero_speed = 0
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		var spell_instance = spell.instance()
		spell_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
		spell_instance.rotation = get_angle_to(get_global_mouse_position())
		attack_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
		get_parent().add_child(spell_instance)
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		attacking = false
		#_hero_speed = 150

