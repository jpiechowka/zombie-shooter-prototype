extends KinematicBody2D


export var enemy_light_speed_min: float = 175.0
export var enemy_light_speed_max: float = 225.0
export var enemy_light_hp: float = 100.0

var enemy_speed: float
var player: Object


func _ready():
	enemy_speed = rand_range(enemy_light_speed_min, enemy_light_speed_max)
	player = get_parent().get_node("Player")
	

func _physics_process(delta):
	# Check if player is not freed
	if is_instance_valid(player):
		var velocity = global_position.direction_to(player.global_position)
		
		# move_and_slide() will apply delta automatically. Do not multiply vector by delta
		move_and_slide(velocity * enemy_speed)
		
		look_at(player.global_position)
