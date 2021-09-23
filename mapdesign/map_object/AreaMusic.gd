extends Area2D

#onready var node = get_node("CollisionShape2D/AudioStreamPlayer2D").set_deferred("playing", false)


func _on_Area2D_body_entered(body):
	get_node("CollisionShape2D/AudioStreamPlayer2D").set_deferred("playing", true)


func _on_Music_area_body_exited(body):
	get_node("CollisionShape2D/AudioStreamPlayer2D").set_deferred("playing", false)
