extends KinematicBody2D


export var player_speed: int = 210
export var player_hp: float = 100.0


func _ready():
	pass


func _physics_process(delta):
	# Player movement
	var player_motion = Vector2()
	if Input.is_action_pressed("player_move_up"):
		player_motion.y -= 1
	if Input.is_action_pressed("player_move_down"):
		player_motion.y += 1
	if Input.is_action_pressed("player_move_right"):
		player_motion.x += 1
	if Input.is_action_pressed("player_move_left"):
		player_motion.x -= 1
	
	player_motion = move_and_slide(player_motion.normalized() * player_speed)
	look_at(get_global_mouse_position())
