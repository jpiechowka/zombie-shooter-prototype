extends Node


export (PackedScene) var enemy_light_scn
export (PackedScene) var enemy_medium_scn
export (PackedScene) var enemy_heavy_scn
export (PackedScene) var enemy_boss_scn


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
	$EnemyTimer.stop()


func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$EnemyTimer.start()


func _on_EnemyTimer_timeout():
	print_debug("Spawning enemies")
	$EnemyPath/EnemySpawnLocation.offset = randi()
	
	# TODO: spawn random enemies of different types. Also with every timeout add more enemies
	var enemy_light = enemy_light_scn.instance()
	add_child(enemy_light)
	enemy_light.position = $EnemyPath/EnemySpawnLocation.position


func _on_ScoreTimer_timeout():
	score += 1
