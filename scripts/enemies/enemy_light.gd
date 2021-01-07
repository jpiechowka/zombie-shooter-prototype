extends KinematicBody2D


export var enemy_light_speed_min: int = 100
export var enemy_light_speed_max: int = 200
export var enemy_light_hp: float = 100.0

var enemy_speed: int

var player: Object


func _ready():
	# TODO: fix
	enemy_speed = randi() % enemy_light_speed_max + enemy_light_speed_min
	print_debug("Light enemy speed: ", enemy_speed)
	
	player = get_parent().get_node("Player")
	

func _physics_process(delta):
	# Check if player is not freed
	if is_instance_valid(player):
		var player_global_pos = player.global_position
		var velocity = global_position.direction_to(player_global_pos)
		
		# move_and_collide() will not apply delta automatically. Multiply vector by delta
		move_and_collide(velocity * enemy_speed * delta) 
		
		look_at(player_global_pos)
