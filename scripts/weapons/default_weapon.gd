extends Node2D


export (PackedScene) var bullet_scn

# TODO: modify values below
# TODO: implement shotgun spread
# TODO: modify this
# TODO: get assembeld weapon from gun designer
export (float, 0.1, 15.0, 0.1) var fire_rate = 2.0  # Bullets per second
export (float, 20.0, 100.0, 0.5) var accuracy = 90.0  # Fire pattern spread
export (int, 1, 1000) var mag_capacity = 30  # Bullets that can be fired between reloads
export (float, 0.5, 25.0, 0.1) var reload_speed_seconds = 2.5 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	# TODO: change to is_action_pressed with fire_rate taken into account
	if Input.is_action_just_pressed("player_shoot"):
		var bullet_instance: BulletBase = bullet_scn.instance()
		get_node("../../").add_child(bullet_instance)  # Add bullet to the fight mode node
		bullet_instance.fire_bullet($MuzzlePos.global_position, get_parent().rotation)  # Get bullet starting position and get player rotation
		bullet_instance.connect("bullet_collided_with_enemy", get_node("../../"), "_on_bullet_hit_enemy")
		
