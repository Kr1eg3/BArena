extends Area2D


func _on_hiden_area_body_entered(body):
	get_node("Sprite").set_deferred("region_enabled", true)
	get_node("tavern").set_deferred("playing", true)
	get_node("AnimatedSprite").set_deferred("visible", false)
	print("enter")


func _on_hiden_area_body_exited(body):
	get_node("Sprite").set_deferred("region_enabled", false)
	get_node("tavern").set_deferred("playing", false)
	get_node("AnimatedSprite").set_deferred("visible", true)
	print("exit")

