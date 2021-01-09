extends KinematicBody2D


signal collided_with_player


var enemy_speed: float = 200.0
var player: Object


func _ready():
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
				print_debug("Enemy collided with player")
				emit_signal("collided_with_player")
		
		look_at(player.global_position)
