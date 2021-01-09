extends MarginContainer


func _ready():
	pass 


func _on_FightBtn_pressed():
	GlobalSceneLoader.goto_scene("res://scenes/game_modes/fight_mode/fight_mode_mockup.tscn")


func _on_ManageBaseBtn_pressed():
	GlobalSceneLoader.goto_scene("res://scenes/game_modes/manage_base_mode_mockup.tscn")


func _on_GunDesignerBtn_pressed():
	GlobalSceneLoader.goto_scene("res://scenes/game_modes/gun_designer.tscn")


func _on_OptionsBtn_pressed():
	GlobalSceneLoader.goto_scene("res://scenes/menus/options_menu.tscn")

