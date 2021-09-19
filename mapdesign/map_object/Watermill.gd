extends KinematicBody2D


onready var mapscene_gui = get_node("..//gui")
var entered_area = preload("res://mapdesign/map_object/area_entered.tscn")


func _ready():
	var entered_area_instance = entered_area.instance()
	add_child(entered_area_instance)
	for area in get_tree().get_nodes_in_group("entered_areas"):
		area.connect("body_entered", mapscene_gui, "OnAreaEntered")
		area.connect("body_exited", mapscene_gui, "OnAreaExited")

