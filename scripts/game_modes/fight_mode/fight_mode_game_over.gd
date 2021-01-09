extends MarginContainer


func _ready():
	pass


func _on_BackToMenuBtn_pressed():
	GlobalSceneLoader.goto_scene("res://scenes/menus/main_menu.tscn")
