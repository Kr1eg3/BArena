extends RigidBody2D

var projectile_speed = 600
var life_time = 1.5
var damage = 300

func _ready():
	apply_impulse(Vector2(), Vector2(projectile_speed, 0).rotated(rotation))
	_self_destruct()
	
	

func _self_destruct():
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()
	

func _on_Ice_Spear_body_entered(body):
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	if body.is_in_group("enemies"):
		body._on_hit(damage)
	self.hide()
