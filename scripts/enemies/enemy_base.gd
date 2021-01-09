extends KinematicBody2D


class_name EnemyBase


signal collided_with_player


var blood_splatter_scn: PackedScene = preload("res://particles/blood_splatter.tscn")

var enemy_speed: float = 200.0
var enemy_hp: float = 100.0
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


func receive_damage_or_die(dmg: float):
	# TODO: orientation of particles is backwards towards player.
	# This is fine, but when enemy is hit at a differnt angle particles will be oriented incorrectly.
	var blood_splatter_particles: Particles2D = blood_splatter_scn.instance()
	add_child(blood_splatter_particles)
	
	enemy_hp = enemy_hp - dmg
	if enemy_hp <= 0:
		queue_free()
		

func bullet_knockback(knockback: float):
	pass
