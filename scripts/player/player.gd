extends KinematicBody2D


export (float, 150.0, 250.0, 2.5) var player_speed = 200.0


func _ready():
	hide()


func _physics_process(delta):
	# Player movement
	var player_motion: Vector2 = Vector2()
	if Input.is_action_pressed("player_move_up"):
		player_motion.y -= 1
	if Input.is_action_pressed("player_move_down"):
		player_motion.y += 1
	if Input.is_action_pressed("player_move_right"):
		player_motion.x += 1
	if Input.is_action_pressed("player_move_left"):
		player_motion.x -= 1
	
	# move_and_collide() will NOT apply delta automatically. Multiply vector by delta
	move_and_collide(player_motion.normalized() * player_speed * delta)
	
	look_at(get_global_mouse_position())


func start(pos: Vector2):
	position = pos
	show()
