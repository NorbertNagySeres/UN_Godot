extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_StartGameButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_ViewHighScoresButton_pressed():
	get_tree().change_scene("res://Scenes/HighScores.tscn")


func _on_Announcements_pressed():
	get_tree().change_scene("res://Scenes/Announcement.tscn")


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")
