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
	print_debug("Game over")
	print_debug("Stopping timers")
	$ScoreTimer.stop()
	$EnemyLightTimer.stop()
	$EnemyMediumTimer.stop()
	$EnemyHeavyTimer.stop()
	$EnemyBossTimer.stop()
	print_debug("Deleting enemies")
	get_tree().call_group("enemies", "queue_free")
	print_debug("Deleting player")
	get_node("Player").call("queue_free")
	print_debug("Switch to game over scene")
	switch_to_gamer_over_scene()


func switch_to_gamer_over_scene():
	GlobalSceneLoader.goto_scene("res://scenes/game_modes/fight_mode/fight_mode_game_over.tscn")


func _on_Player_collided_with_enemy():
	game_over()


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
	spawn_enemies(enemy_light_scn, light_enemies_spawn_num)
	
	if light_enemies_spawn_num < max_light_enemies_spawn_num:
		light_enemies_spawn_num += 1


func _on_EnemyMediumTimer_timeout():
	print_debug("Spawning medium enemies, num: ", medium_enemies_spawn_num)
	spawn_enemies(enemy_medium_scn, medium_enemies_spawn_num)
	
	if medium_enemies_spawn_num < max_medium_enemies_spawn_num:
		medium_enemies_spawn_num += 1


func _on_EnemyHeavyTimer_timeout():
	print_debug("Spawning heavy enemies, num: ", heavy_enemies_spawn_num)
	spawn_enemies(enemy_heavy_scn, heavy_enemies_spawn_num)
	
	if heavy_enemies_spawn_num < max_heavy_enemies_spawn_num:
		heavy_enemies_spawn_num += 1


func _on_EnemyBossTimer_timeout():
	print_debug("Spawning boss enemies, num: ", boss_enemies_spawn_num)
	spawn_enemies(enemy_boss_scn, boss_enemies_spawn_num)
	
	if boss_enemies_spawn_num < max_boss_enemies_spawn_num:
		boss_enemies_spawn_num += 1


func spawn_enemies(enemy_scene: PackedScene, spawn_num: int):
	for _n in range(spawn_num):
		var enemy_instance: Node = enemy_scene.instance()
		
		if enemy_instance.connect("collided_with_player", self, "game_over", [], CONNECT_ONESHOT):
			print_debug("Error when connecting enemy signal")
			return
		
		$EnemyPath/EnemySpawnLocation.offset = randi()
		add_child(enemy_instance)
		enemy_instance.position = $EnemyPath/EnemySpawnLocation.position
