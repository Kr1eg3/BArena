extends "res://character_super_class_script/player.gd"

#class_name Test

var limon_characteristics
var limon_spells

var path_to_characteristics = "res://hero_limon/limon_data/Limon.json"
var path_to_limon_spells = "res://hero_limon/limon_spells/limon_spells_data/Limon_spells.json"


func _ready():
	limon_characteristics = _parse_datafile(path_to_characteristics)
	limon_spells = _parse_datafile(path_to_limon_spells)
	
	_get_chars(limon_characteristics)

func _spells():
	pass

func _dops_func():
	print('2')
	
func _physics_process(delta):
	working(delta)
	#_dop_func()



