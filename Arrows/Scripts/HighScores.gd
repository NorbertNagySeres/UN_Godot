extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var headers = []
	$HTTPRequest.request("https://un-server.herokuapp.com/scores");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	$Names.clear()
	$Scores.clear()
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			print("SUCCESS");
			var score_json = JSON.parse(body.get_string_from_utf8())
			print(score_json.result)
			for score in score_json.result:
				if(score.username != null and score.score != null):
					$Names.add_item(score.username)
					$Scores.add_item(str(score.score))
		else:
			print("Http Error")
			print(response_code)
	else:
		print("ERROR")
	


func _on_PlayAgain_pressed():
	Global.game_restarted = true
	Global.reset_every_value()
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_TodayButton_pressed():
	$HTTPRequest.request("https://un-server.herokuapp.com/scores/day")


func _on_AllTimeButton_pressed():
	$HTTPRequest.request("https://un-server.herokuapp.com/scores")


func _on_MonthButton_pressed():
	$HTTPRequest.request("https://un-server.herokuapp.com/scores/month")


func _on_YearButton_pressed():
	$HTTPRequest.request("https://un-server.herokuapp.com/scores/year")


func _on_MenuButton_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
