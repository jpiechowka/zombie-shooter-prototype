extends "res://scripts/enemies/enemy_base.gd"


export (float, 125.0, 175.0, 2.5) var enemy_medium_speed_min = 150.0
export (float, 180.0, 200.0, 2.5) var enemy_medium_speed_max = 190.0
export (float, 500, 1500, 5.0) var enemy_medium_hp = 550.0


func _ready():
	enemy_speed = rand_range(enemy_medium_speed_min, enemy_medium_speed_max)
	enemy_hp = enemy_medium_hp
