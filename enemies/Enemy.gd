# Base class for all enemies.
extends RigidBody2D

class_name Enemy

signal died

@onready var player := get_tree().root.get_node("Main/Player")
@onready var animated_sprite := $AnimatedSprite2D
@onready var animation_player := $AnimationPlayer
@onready var damage_label := $DamageLabel
@onready var damage_label_timer := $DamageLabel/Timer
var damage: int
var direction: Vector2
var enemy_name: String
var health: int
var speed: float


func _integrate_forces(state):
	state.linear_velocity = direction * speed


func die():
	emit_signal("died")
	queue_free()


func hit(damage_in: int):
	health -= damage_in
	damage_label.text = str(damage_in)
	damage_label.visible = true
	damage_label_timer.start()
	if health <= 0:
		die()
	else:
		animation_player.play("hit")


func _on_ai_timer_timeout():
	direction = (player.position - position).normalized()


func _on_timer_timeout():
	damage_label.visible = false
