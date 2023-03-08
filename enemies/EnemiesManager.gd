extends Node

class_name EnemiesManager

const DEFAULT_SPAWN_TIME := 0.1
const MAX_ENEMIES := 300

@onready var player := get_tree().root.get_node("Main/Player")
@onready var enemy_spawner := $EnemySpawner
@onready var enemy_spawn_location := $EnemySpawner/EnemySpawnLocation
@onready var spawn_timer := $SpawnTimer

var rng := RandomNumberGenerator.new()
# Enemies
var enemies_count := 0
enum { DOOM_STAR, RED_DOOM_STAR }
var doom_star_scene := preload("res://enemies/doom star/DoomStar.tscn")
var red_doom_star_scene := preload("res://enemies/red doom star/RedDoomStar.tscn")


func _ready():
	spawn_timer.wait_time = DEFAULT_SPAWN_TIME
	spawn_timer.start()


func instance_enemy(enemy_type):
	var enemy: Enemy = null
	match enemy_type:
		DOOM_STAR:
			enemy = doom_star_scene.instantiate()
		RED_DOOM_STAR:
			enemy = red_doom_star_scene.instantiate()
		_:
			print("Wrong enemy")
	assert(enemy)
	get_tree().root.get_node("Main").call_deferred("add_child", enemy)
	var err := enemy.connect("died", _on_enemy_death)
	assert(!err)
	enemy_spawn_location.progress_ratio = randi()
	enemy.position = enemy_spawn_location.global_position + player.global_position

	enemies_count += 1


func spawn_enemy():
	# maybe someday we need to check if spawn position is not occupied
	var dice_result := rng.randi_range(1, 100)
	if dice_result < 99:
		instance_enemy(DOOM_STAR)
	else:
		instance_enemy(RED_DOOM_STAR)


#func spawn_enemy(enemy: Enemy):
#	# Check if it's a valid position
#	var valid_position := false
#	while not valid_position:
#		enemy_spawn_location.offset = randi()
##		valid_position = test_position(enemy_spawn_location.position + player.position)
#		valid_position = true
#	enemy.position = enemy_spawn_location.position + player.position


func _on_enemy_death():
	enemies_count -= 1


func _on_spawn_timer_timeout():
	if enemies_count < MAX_ENEMIES:
		spawn_enemy()
