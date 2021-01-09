extends "res://scripts/enemies/enemy_base.gd"


export (float, 75.0, 115.0, 2.5) var enemy_heavy_speed_min = 100.0
export (float, 125.0, 175.0, 2.5) var enemy_heavy_speed_max = 150.0
export (float, 2000.0, 5000.0, 100.0) var enemy_heavy_hp = 2500.0


func _ready():
	enemy_speed = rand_range(enemy_heavy_speed_min, enemy_heavy_speed_max)
	enemy_hp = enemy_heavy_hp
