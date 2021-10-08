extends KinematicBody2D

var max_hp = 400
var current_hp 
var animation_of_dath = 3

func _ready():
	get_node("AnimationPlayer").play("Idle_w")
	current_hp = max_hp
	
func _on_hit(damage):
	current_hp -= damage
	if current_hp <= 0:
		_on_death()
		

func _on_death():
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	get_node("AnimationPlayer").play("death_w")
	#get_node("AudioStreamPlayer2D").set_deferred("playing", true)
	yield(get_tree().create_timer(animation_of_dath), "timeout")
	queue_free()
	
