extends Node2D

export (PackedScene) var block_scene
export (PackedScene) var bonus_scene
export (PackedScene) var joystick_scene

var block_spawn_delay = 0.3
var bonus_spawn_delay = 5
var rng = RandomNumberGenerator.new()
var block_position = Vector2()
var bonus_position = Vector2()
var block_timer = Timer.new()
var bonus_timer = Timer.new()
var timer = Timer.new()
var timer_time = 10
var joystick
var joystick_button

func _ready():
	Global.reset_every_value()
	initialize_block_timer()
	initialize_bonus_timer()
	if Global.control == 1:
		joystick = joystick_scene.instance()
		call_deferred("add_child", joystick)
		joystick_button = joystick.get_child(0).get_child(0)

func _process(delta):
	if Global.bonus_activated:
		print("BLA1")
		if Global.bonus_type == "make_all_blocks_same_color":
			print("BLA2")
			Global.same_colors = true
			initialize_timer()
	if Global.control == 1:
		#print(joystick.position)
		#print(joystick.get_value())
		$Player.move_by_joystick(joystick_button.get_value())

func spawn_new_block():
	var new_block = block_scene.instance()
	new_block.position = block_position
	call_deferred("add_child", new_block)
	
func spawn_new_bonus():
	var new_bonus = bonus_scene.instance()
	new_bonus.position = bonus_position
	call_deferred("add_child", new_bonus)
	
func on_timeout_complete():
	print("TIMEOUT")
	block_position = randomPosition()
	spawn_new_block()
	
func on_bonus_timeout_complete():
	print("BONUS_TIMEOUT")
	bonus_position = randomPosition()
	spawn_new_bonus()	
	

func randomPosition():
	rng.randomize()
	var random_number = rng.randi_range(60, 660)
	return Vector2(1600, random_number)

func initialize_block_timer():
	block_timer.set_wait_time(block_spawn_delay)
	block_timer.connect("timeout", self, "on_timeout_complete")
	add_child(block_timer)
	block_timer.start()
	print(Global.player_color)

func initialize_bonus_timer():
	bonus_timer.set_wait_time(bonus_spawn_delay)
	bonus_timer.connect("timeout", self, "on_bonus_timeout_complete")
	add_child(bonus_timer)
	bonus_timer.start()

func initialize_timer():
	timer.set_wait_time(timer_time)
	timer.connect("timeout", self, "timeout_complete")
	add_child(timer)
	timer.start()

func timeout_complete():
	Global.same_colors = false
