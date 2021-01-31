extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request("https://un-server.herokuapp.com/announcement")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			print("SUCCESS");
			var announcement = body.get_string_from_utf8()
			$Label.text = announcement
		else:
			print("Http Error")
			print(response_code)
	else:
		print("ERROR")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
