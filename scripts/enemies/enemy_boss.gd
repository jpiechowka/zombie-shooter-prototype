extends KinematicBody2D


signal collided_with_player


export (float, 50.0, 90.0, 2.5) var enemy_boss_speed_min = 75.0
export (float, 100.0, 150.0, 2.5) var enemy_boss_speed_max = 100.0
export (float, 10000.0, 25000.0, 500.0) var enemy_boss_hp = 15000.0

var enemy_speed: float
var player: Object


func _ready():
	enemy_speed = rand_range(enemy_boss_speed_min, enemy_boss_speed_max)
	print_debug("Boss enemy speed: ", enemy_speed)
	player = get_parent().get_node("Player")


func _physics_process(delta):
	# Check if player is not freed
	if is_instance_valid(player):
		var velocity = global_position.direction_to(player.global_position)
		
		# move_and_collide() will NOT apply delta automatically. Multiply vector by delta
		# velocity is already normalized
		var collision: KinematicCollision2D = move_and_collide(velocity * enemy_speed * delta)
		if collision:
			if "Player" in collision.collider.name:
				print_debug("Boss collided with player")
				emit_signal("collided_with_player")
		
		look_at(player.global_position)
