extends Node


export (PackedScene) var enemy_light_scn
export (PackedScene) var enemy_medium_scn
export (PackedScene) var enemy_heavy_scn
export (PackedScene) var enemy_boss_scn

# Initial number of spawned enemies
export var light_enemies_spawn_num = 4
export var medium_enemies_spawn_num = 3
export var heavy_enemies_spawn_num = 2
export var boss_enemies_spawn_num = 1

# TODO: rename to gold maybe?
var score = 0


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
		$EnemyPath/EnemySpawnLocation.offset = randi()
		var enemy_light = enemy_light_scn.instance()
		add_child(enemy_light)
		enemy_light.position = $EnemyPath/EnemySpawnLocation.position
		
	light_enemies_spawn_num += 1


func _on_EnemyMediumTimer_timeout():
	print_debug("Spawning medium enemies, num: ", medium_enemies_spawn_num)
	
	for _n in range(medium_enemies_spawn_num):
		$EnemyPath/EnemySpawnLocation.offset = randi()
		var enemy_medium = enemy_medium_scn.instance()
		add_child(enemy_medium)
		enemy_medium.position = $EnemyPath/EnemySpawnLocation.position
		
	medium_enemies_spawn_num += 1


func _on_EnemyHeavyTimer_timeout():
	print_debug("Spawning heavy enemies, num: ", heavy_enemies_spawn_num)
	
	for _n in range(heavy_enemies_spawn_num):
		$EnemyPath/EnemySpawnLocation.offset = randi()
		var enemy_heavy = enemy_heavy_scn.instance()
		add_child(enemy_heavy)
		enemy_heavy.position = $EnemyPath/EnemySpawnLocation.position
		
	heavy_enemies_spawn_num += 1


func _on_EnemyBossTimer_timeout():
	print_debug("Spawning boss enemies, num: ", boss_enemies_spawn_num)
	
	for _n in range(boss_enemies_spawn_num):
		$EnemyPath/EnemySpawnLocation.offset = randi()
		var enemy_boss = enemy_boss_scn.instance()
		add_child(enemy_boss)
		enemy_boss.position = $EnemyPath/EnemySpawnLocation.position
