# Base class for all enemies.
extends RigidBody2D

class_name Enemy

signal death

@onready var player := get_tree().root.get_node("Main/Player")
@onready var animated_sprite := $AnimatedSprite2D

var damage: int
var direction: Vector2
var enemy_name: String
var health: int
var speed: float


func _integrate_forces(state):
#	var target_position = player.global_transform.origin
	state.linear_velocity = direction * speed


# not in use
func look_follow(state, current_transform, target_position):
	var up_dir = Vector3(0, 1, 0)
	var cur_dir = current_transform.basis * Vector3(0, 0, 1)
	var target_dir = (target_position - current_transform.origin).normalized()
	var rotation_angle = acos(cur_dir.x) - acos(target_dir.x)

	state.angular_velocity = up_dir * (rotation_angle / state.step)


func hit(damage_in: int):
	health -= damage_in
	if health < 0.0:
		emit_signal("death")
		get_tree().queue_delete(self)


func _on_ai_timer_timeout():
	direction = (player.position - position).normalized()
