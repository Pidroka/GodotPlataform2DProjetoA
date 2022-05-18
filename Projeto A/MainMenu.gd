extends Control

var startGame

func _ready():
	$VBoxContainer/StartButton.grab_focus()



func _on_StartButton_pressed():
	startGame = get_tree().change_scene("res://World.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
