extends KinematicBody2D

const BASE_MOVEMENT_SPEED = -400

var movement_speed = BASE_MOVEMENT_SPEED - Global.speed_coefficient * 30
var movement = Vector2()
var block_color

var red_texture = preload("res://Sprites/red_circle_final.png")
var blue_texture = preload("res://Sprites/blue_circle_final.png")
var green_texture = preload("res://Sprites/green_circle_final.png")

var rng = RandomNumberGenerator.new()

func _ready():
	print("NEW BLOCK SPAWNED")
	if Global.same_colors:
		print("Spawning same color blocks")
		block_color = Global.player_color
		match block_color:
			"blue": $Sprite.texture = blue_texture
			"green": $Sprite.texture = green_texture
			"red": $Sprite.texture = red_texture
	else:
		print("Spawning different color blocks")
		randomColor()
			

func _physics_process(delta):
	movement.x =movement_speed
	move_and_slide(movement)
	
	if position.x < 0:
		queue_free()

func randomColor():
	rng.randomize()
	var random_number = rng.randi_range(0, 2)
	match random_number:
		0: 
			$Sprite.texture = blue_texture
			block_color = "blue"
		1: 
			$Sprite.texture = green_texture
			block_color = "green"
		2: 
			$Sprite.texture = red_texture
			block_color = "red"


func _on_Area2D_body_entered(body):
	if Global.player_color == block_color:
		Global.score += 1
		Global.speed_coefficient += 1
		queue_free()
	else:
		get_parent().queue_free()
		get_tree().change_scene("res://Scenes/Game_over.tscn")
		
