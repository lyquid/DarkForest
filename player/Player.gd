extends CharacterBody2D

class_name Player

@onready var animated_sprite := $AnimatedSprite2D

var speed := 200.0
var last_moving_direction := Vector2(1.0, 0.0)
var enemies := []


func _ready():
	animated_sprite.play("idle")


func are_enemies_available() -> bool:
	return enemies.size() > 0


func get_input():
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if input_direction.length_squared() > 0.0:
		last_moving_direction = input_direction


func get_last_moving_direction() -> Vector2:
	return last_moving_direction


func get_nearest_enemy() -> Enemy:
	var current_index := 0
	var nearest_enemy_index: int
	var shortest_distance := INF
	# you should always check "are_enemies_available" before calling this func
	assert(not enemies.is_empty())
	for enemy in enemies:
		var current_distance = enemy.global_position.distance_squared_to(global_position)
		if current_distance < shortest_distance:
			shortest_distance = current_distance
			nearest_enemy_index = current_index
		current_index += 1

	return enemies[nearest_enemy_index]


func _physics_process(_delta):
	get_input()
	move_and_slide()


func _on_enemy_engagement_zone_body_entered(body: Enemy):
	enemies.push_back(body)


func _on_enemy_engagement_zone_body_exited(body: Enemy):
	for enemy in enemies:
		if enemy == body:
			enemies.erase(enemy)
			return
