extends "res://scripts/enemies/enemy_base.gd"


export (float, 150.0, 200.0, 2.5) var enemy_light_speed_min = 185.0
export (float, 210.0, 250.0, 2.5) var enemy_light_speed_max = 225.0
export (float, 75.0, 350.0, 5.0) var enemy_light_hp = 100.0


func _ready():
	enemy_speed = rand_range(enemy_light_speed_min, enemy_light_speed_max)
