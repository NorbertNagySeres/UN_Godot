extends Control

var score_file = "user://highscore.txt"
var highscore = 0
var saved_username

# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreLabel.text = str(Global.score)
	load_score()
	$NameInput.text = saved_username
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$Loading.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_score():
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content = f.get_as_text()
		saved_username = content
		f.close()
		
func save_username(username):
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(username)
	f.close()

func _on_Button_pressed():
	save_username($NameInput.text)
	var username = $NameInput.text
	print($NameInput.text)
	print(username)
	
	var data_to_send = {
		"username": username,
		"score": Global.score
	}	
	var json_to_send = JSON.print(data_to_send)
	var headers = ["Content-Type: application/json"]
	$Loading.show()
	$HTTPRequest.request("https://un-server.herokuapp.com/score", headers, false, HTTPClient.METHOD_POST, json_to_send);
	
	print(username)

	

func _on_request_completed(result, response_code, headers, body):
	print("LOADING FINISHED")
	$Loading.hide()
	get_tree().change_scene("res://Scenes/HighScores.tscn")
	
func _on_PlayAgain_pressed():
	Global.game_restarted = true
	Global.reset_every_value()
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_BackToMenuButton_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
