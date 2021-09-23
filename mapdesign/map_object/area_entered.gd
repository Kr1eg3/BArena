extends Area2D






func _on_area_entered_body_entered(body):
	get_tree().change_scene("res://watermill.tscn")
