extends Node


export (PackedScene) var enemy_light_scn
export (PackedScene) var enemy_medium_scn
export (PackedScene) var enemy_heavy_scn
export (PackedScene) var enemy_boss_scn

# Initial number of spawned enemies
export (int, 3, 50) var light_enemies_spawn_num = 4
export (int, 2, 40) var medium_enemies_spawn_num = 3
export (int, 1, 30) var heavy_enemies_spawn_num = 2
export (int, 1, 20) var boss_enemies_spawn_num = 1

# Max numbers of enemies to spawn at one time
export (int, 10, 50) var max_light_enemies_spawn_num = 20
export (int, 5, 40) var max_medium_enemies_spawn_num = 15
export (int, 5, 30) var max_heavy_enemies_spawn_num = 10
export (int, 3, 20) var max_boss_enemies_spawn_num = 5

# TODO: rename to gold maybe?
var score: int = 0


func _ready():
	randomize()  # Seed the RNG
	new_game()


func new_game():
	score = 0
	$Player.start($PlayerStartingPos.position)
	$StartTimer.start()
	

func game_over():
	$ScoreTimer.stop()
	$EnemyLightTimer.stop()
	$EnemyMediumTimer.stop()
	$EnemyHeavyTimer.stop()
	$EnemyBossTimer.stop()


func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$EnemyLightTimer.start()
	$EnemyMediumTimer.start()
	$EnemyHeavyTimer.start()
	$EnemyBossTimer.start()


func _on_ScoreTimer_timeout():
	score += 1


func _on_EnemyLightTimer_timeout():
	print_debug("Spawning light enemies, num: ", light_enemies_spawn_num)
	
	for _n in range(light_enemies_spawn_num):
		var enemy_light = enemy_light_scn.instance()
		spawn_enemy(enemy_light)
	
	if light_enemies_spawn_num < max_light_enemies_spawn_num:
		light_enemies_spawn_num += 1


func _on_EnemyMediumTimer_timeout():
	print_debug("Spawning medium enemies, num: ", medium_enemies_spawn_num)
	
	for _n in range(medium_enemies_spawn_num):
		var enemy_medium = enemy_medium_scn.instance()
		spawn_enemy(enemy_medium)
	
	if medium_enemies_spawn_num < max_medium_enemies_spawn_num:
		medium_enemies_spawn_num += 1


func _on_EnemyHeavyTimer_timeout():
	print_debug("Spawning heavy enemies, num: ", heavy_enemies_spawn_num)
	
	for _n in range(heavy_enemies_spawn_num):
		var enemy_heavy = enemy_heavy_scn.instance()
		spawn_enemy(enemy_heavy)
	
	if heavy_enemies_spawn_num < max_heavy_enemies_spawn_num:
		heavy_enemies_spawn_num += 1


func _on_EnemyBossTimer_timeout():
	print_debug("Spawning boss enemies, num: ", boss_enemies_spawn_num)
	
	for _n in range(boss_enemies_spawn_num):
		var enemy_boss = enemy_boss_scn.instance()
		spawn_enemy(enemy_boss)
		
	if boss_enemies_spawn_num < max_boss_enemies_spawn_num:
		boss_enemies_spawn_num += 1


func spawn_enemy(enemy_instance: Object):
	$EnemyPath/EnemySpawnLocation.offset = randi()
	add_child(enemy_instance)
	enemy_instance.position = $EnemyPath/EnemySpawnLocation.position
