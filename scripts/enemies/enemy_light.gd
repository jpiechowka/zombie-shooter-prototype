extends KinematicBody2D


signal collided_with_player


export (float, 150.0, 190.0, 2.5) var enemy_light_speed_min = 175.0
export (float, 200.0, 230.0, 2.5) var enemy_light_speed_max = 225.0
export (float, 75.0, 350.0, 5.0) var enemy_light_hp = 100.0

var enemy_speed: float
var player: Object


func _ready():
	enemy_speed = rand_range(enemy_light_speed_min, enemy_light_speed_max)
	print_debug("Light enemy speed: ", enemy_speed)
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
				print_debug("Light enemy collided with player")
				emit_signal("collided_with_player")
		
		look_at(player.global_position)
