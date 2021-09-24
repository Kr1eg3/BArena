extends Area2D


func _on_Area2D_body_entered(body):
	var scene = preload("res://mapdesign/map_object/Watermill.tscn")
	var node = scene.instance()
	add_child(node)
	
