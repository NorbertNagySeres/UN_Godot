extends KinematicBody2D

const BASE_MAX_SPEED = 600
const BASE_ACCELERATION = 1200

var max_speed = BASE_MAX_SPEED
var speed = 0
var acceleration = BASE_ACCELERATION
var move_direction
var moving = false
var destination = Vector2()
var movement = Vector2()
var speed_timer = Timer.new()
var speed_up_timer_time = 10

var deltaX
var deltaY
var touchPos = Vector2()
var newDeltaX
var newDeltaY

#if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
var rng = RandomNumberGenerator.new()

var red_player_texture = preload("res://Sprites/player_texture_red.png")
var green_player_texture = preload("res://Sprites/player_texture_green.png")
var blue_player_texture = preload("res://Sprites/blue_player_texture_2.png")

func _ready():
	randomColor()

func _input(event):
	if event is InputEventScreenDrag or event is InputEventScreenTouch:
			moving = true
			destination.x = get_global_mouse_position().x + 100
			destination.y = get_global_mouse_position().y
			print(acceleration)
	
#	if event is InputEventScreenTouch and event.is_pressed():
#		touchPos = event.get_position()
#		deltaX = touchPos.x - position.y
#		deltaY = touchPos.y - position.y
#	elif event is InputEventScreenDrag:
#		touchPos = event.get_position()
#		newDeltaX = touchPos.x - deltaX
#		newDeltaY = touchPos.y - deltaY
#		movement = move_and_slide(Vector2(newDeltaX, newDeltaY))
#		print(movement)

func _process(delta):
	if Global.bonus_activated:
		Global.bonus_activated = false
		match Global.bonus_type:
			"speed_up_player":
				initialize_speed_up_timer()
				max_speed += 250
				acceleration = acceleration * 2
			"slow_down_blocks":
				pass
			"stop_time":
				pass
	
func _physics_process(delta):
	if Global.control == 0:
		MovementLoop(delta)
	
	
func move_by_joystick(value):
	print(value)
	move_and_slide(value * 400)
	
	
func MovementLoop(delta):
	if moving == false:
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
	movement = position.direction_to(destination) * speed
	move_direction = rad2deg(destination.angle_to_point(position))
	if position.distance_to(destination) > 20 :
		movement = move_and_slide(movement)
	else:
		moving = false

func randomColor():
	rng.randomize()
	var random_number = rng.randi_range(0, 2)
	match random_number:
		0: 
			$Sprite.texture = blue_player_texture
			Global.player_color = "blue"
		1: 
			$Sprite.texture = green_player_texture
			Global.player_color = "green"
		2: 
			$Sprite.texture = red_player_texture
			Global.player_color = "red"
			
func initialize_speed_up_timer():
	speed_timer.set_wait_time(speed_up_timer_time)
	speed_timer.connect("timeout", self, "on_speed_up_timeout_complete")
	add_child(speed_timer)
	speed_timer.start()

func on_speed_up_timeout_complete():
	max_speed = BASE_MAX_SPEED
	acceleration = BASE_ACCELERATION
