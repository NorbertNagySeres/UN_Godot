extends Node

var score = 0
var player_color

var bonus_activated = false
var bonus_type

var speed_coefficient = 0

var same_colors = false

var game_restarted = false

var user_name

var control = 0

func _ready():
	pass # Replace with function body.
	
func reset_every_value():
	score = 0
	bonus_activated = false
	speed_coefficient = 0
	same_colors = false
	game_restarted = false

