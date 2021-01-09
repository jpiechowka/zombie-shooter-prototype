extends KinematicBody2D


signal collided_with_player


export (float, 125.0, 175.0, 2.5) var enemy_medium_speed_min = 140.0
export (float, 150.0, 190.0, 2.5) var enemy_medium_speed_max = 175.0
export (float, 500, 1500, 5.0) var enemy_medium_hp = 550.0

var enemy_speed: float
var player: Object


func _ready():
	enemy_speed = rand_range(enemy_medium_speed_min, enemy_medium_speed_max)
	print_debug("Medium enemy speed: ", enemy_speed)
	player = get_parent().get_node("Player")
	

func _physics_process(delta):
	# Check if player is not freed
	if is_instance_valid(player):
		var velocity: Vector2 = global_position.direction_to(player.global_position)
		
		# move_and_collide() will NOT apply delta automatically. Multiply vector by delta
		# velocity is already normalized
		var collision: KinematicCollision2D = move_and_collide(velocity * enemy_speed * delta)
		if collision:
			if "Player" in collision.collider.name:
				print_debug("Medium enemy collided with player")
				emit_signal("collided_with_player")
		
		look_at(player.global_position)
