extends KinematicBody2D

var MOVEMENT_SPEED = -400 - Global.speed_coefficient * 30
var movement = Vector2()
var bonus_type 
var speed_up_texture = preload("res://Sprites/speed_up.png")
var slow_down_texture = preload("res://Sprites/slow_down.png")
var same_color_texture = preload("res://Sprites/same_color.png")

var rng = RandomNumberGenerator.new()

func _ready():
	randomColor()

func _physics_process(delta):
	
	movement.x = MOVEMENT_SPEED
	move_and_slide(movement)
	
	if position.x < 0:
		queue_free()

func randomColor():
	rng.randomize()
	var random_number = rng.randi_range(0, 2)
	match random_number:
		0: 
			$Sprite.texture = speed_up_texture
			bonus_type = "speed_up_player"
		1: 
			$Sprite.texture = slow_down_texture
			bonus_type = "slow_down_blocks"
		2: 
			$Sprite.texture = same_color_texture
			bonus_type = "make_all_blocks_same_color"



func _on_Area2D_body_entered(body):
	print("BONUS_CAPTURED")
	match bonus_type:
		"speed_up_player":
			Global.bonus_activated = true
			Global.bonus_type = bonus_type
		"slow_down_blocks":
			print("SLOW_DOWN_BONUS")
			if(Global.speed_coefficient > 7):
				Global.speed_coefficient -= 7
			else:
				Global.speed_coefficient = 0
		"make_all_blocks_same_color":
			print("BLA0")
			Global.bonus_activated = true
			Global.bonus_type = bonus_type
			print(Global.bonus_activated)
	queue_free()
