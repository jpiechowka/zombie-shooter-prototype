extends MarginContainer


# Called when the node enters the scene tree for the first time
func _ready():
	pass


func _on_BackBtn_pressed():
	GlobalSceneLoader.goto_scene("res://scenes/menus/main_menu.tscn")
