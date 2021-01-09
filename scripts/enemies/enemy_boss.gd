extends "res://scripts/enemies/enemy_base.gd"


export (float, 50.0, 90.0, 2.5) var enemy_boss_speed_min = 75.0
export (float, 100.0, 150.0, 2.5) var enemy_boss_speed_max = 110.0
export (float, 10000.0, 25000.0, 500.0) var enemy_boss_hp = 15000.0


func _ready():
	enemy_speed = rand_range(enemy_boss_speed_min, enemy_boss_speed_max)
	print_debug("Boss enemy speed: ", enemy_speed)
