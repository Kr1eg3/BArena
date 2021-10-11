extends KinematicBody2D
# Супер-класс персонажа

class_name Player

onready var animation_tree = get_node("AnimationTree")
onready var animation_mode = animation_tree.get("parameters/playback")

var data
var item_data

var player_name
var curr_hp
var curr_mp 
var max_hp
var max_mp 
var mv_sp
var aa_dmg
var hp_reg
var mp_reg


# Атрибуты для функции движения
var moving = false
var destination = Vector2()
var movement = Vector2()
var _player_speed = 0
var _player_accel = 200
var _player_max_speed 

# Атрибуты которые могут изменяться 
var _player_curr_hp
var _player_curr_mp

var _cast_first_spell
var _cast_second_spell
var _cast_third_spell
var _cast_fourth_spell

# Функция-конструктор
func _get_chars(_data):
	# Принимаем спаршенный словарь с характеристиками
	data = _data
	
	# Характеристики персонажа из JSON файла
	player_name = data["name"]
	max_hp = data["hp_pull"]
	max_mp = data["mana_pull"]
	mv_sp = data["movement_speed"]
	aa_dmg = data["auto_atack_damage"]
	hp_reg = data["hp_regen"]
	mp_reg = data["mana_regen"]
	
	_player_max_speed = mv_sp
	_player_curr_hp = max_hp
	_player_curr_mp = max_mp
	

func _parse_datafile(path_to_file):
	var itemdata_file = File.new()
	itemdata_file.open(path_to_file, File.READ)
	var itemdata_json = JSON.parse(itemdata_file.get_as_text())
	itemdata_file.close()
	item_data = itemdata_json.result
	
	return item_data

func _unhandled_input(event):
	if event.is_action_pressed("right_click"):
		moving = true
		destination = get_global_mouse_position()
	if event.is_action_pressed("ui_cast_first"):
		_cast_first_spell = true
		moving = false
	if event.is_action_pressed("ui_cast_second"):
		_cast_second_spell = true
		moving = false
	if event.is_action_pressed("ui_cast_third"):
		_cast_third_spell = true
		moving = false
	if event.is_action_pressed("ui_cast_fourth"):
		_cast_fourth_spell = true
		moving = false
		
func stats_regen():
	if _player_curr_hp < max_hp:
		_player_curr_hp += hp_reg
		if _player_curr_hp > max_hp:
			_player_curr_hp = max_hp
	if _player_curr_mp < max_mp:
		_player_curr_mp += mp_reg
		if _player_curr_mp > max_mp:
			_player_curr_mp = max_mp

func _movement_loop(delta):
	if moving == false:
		_player_speed = 0
	else:
		_player_speed += _player_accel * delta
		if	 _player_speed > _player_max_speed:
			_player_speed = _player_max_speed
	movement = position.direction_to(destination) * _player_speed
	if position.distance_to(destination) > 5:
		movement = move_and_slide(movement)
		animation_tree.set('parameters/Run/blend_position', movement.normalized())
		animation_tree.set('parameters/Idle/blend_position', movement.normalized())
		animation_mode.travel("Run")
	else:
		moving = false
		animation_mode.travel("Idle")
		
func _dop_func():
	print('1')

func move(delta):
	# При движении, после нажатия каста, анимация перходит в айдл_с 
	# не зависимо от предыдущего направления движения
	# Фиск: добавление в анимационное дерево анимации проигрывания 
	# спелла, и подключение его в конечный автомат
	_movement_loop(delta)

func atack():
	print('Im atacking!')

func cast_spell():
	# Заглушка через анимации, каждый каст должен соотвествовать анимации 
	# и ждать её окончания, чтобы потом применить следующий спелл, если он
	# не на кд
	if _cast_first_spell == true:
		print('Im casting first spell!')
		_cast_first_spell = false
	elif _cast_second_spell == true:
		print('Im casting second spell!')
		_cast_second_spell = false
	elif _cast_third_spell == true:
		print('Im casting third spell!')
		_cast_third_spell = false
	elif _cast_fourth_spell == true:
		print('Im casting fourth spell!')
		_cast_fourth_spell = false
	

func passive():
	# Пассивное восстановление здоровья
	stats_regen()

func do_stuff():
	print('Im doing stuff!')


func working(delta):
	# Функция, содержащая в себе алгоритм работы персонажа
	# Вызывается в функции _physics_process() в скрипте персонажа
	passive()
	cast_spell()
	move(delta)

