extends CharacterBody2D

class_name Player

var speed := 200.0
var last_moving_direction := Vector2(1.0, 0.0)

@onready var animated_sprite := $AnimatedSprite2D


func _ready():
	animated_sprite.play("idle")


func get_input():
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if input_direction.length_squared() > 0.0:
		last_moving_direction = input_direction


func get_last_moving_direction() -> Vector2:
	return last_moving_direction


func _physics_process(_delta):
	get_input()
	move_and_slide()
