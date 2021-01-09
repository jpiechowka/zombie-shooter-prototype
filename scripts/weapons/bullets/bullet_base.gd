extends KinematicBody2D


class_name BulletBase


signal bullet_collided_with_enemy


var bullet_speed: float = 1000.0
var bullet_time_to_live_seconds: float = 2.0
var bullet_damage: float = 25.0
var bullet_knockback: float = 5.0

var bullet_ttl_timer: Timer = Timer.new()
var velocity: Vector2 = Vector2()


func _ready():
	bullet_ttl_timer.wait_time = bullet_time_to_live_seconds
	bullet_ttl_timer.autostart = false
	bullet_ttl_timer.one_shot = true
	add_child(bullet_ttl_timer)
	bullet_ttl_timer.connect("timeout", self, "_on_bullet_ttl_timer_timeout")


func _physics_process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		if "Enemy" in collision.collider.name:
			print_debug("Bullet hit enemy: ", collision.collider.name)
			emit_signal("bullet_collided_with_enemy", collision.collider.name, bullet_damage, bullet_knockback)
		
		bullet_ttl_timer.stop()
		queue_free()
	
	
func fire_bullet(initial_bullet_position: Vector2, initial_bullet_direction: float):
	rotation = initial_bullet_direction
	position = initial_bullet_position
	velocity = Vector2(bullet_speed, 0).rotated(rotation)
	bullet_ttl_timer.start()
	
	
func _on_bullet_ttl_timer_timeout():
	print_debug("Bullet TTL expired")
	queue_free()
