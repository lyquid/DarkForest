extends Node

class_name EnemiesManager

const DEFAULT_SPAWN_TIME := 0.2
const MAX_ENEMIES := 10

@onready var player := get_tree().root.get_node("Main/Player")
@onready var enemy_spawner := $EnemySpawner
@onready var enemy_spawn_location := $EnemySpawner/EnemySpawnLocation
@onready var spawn_timer := $SpawnTimer

var rng := RandomNumberGenerator.new()

var starting_enemies := 6
var enemies_count := 0
# Enemies
enum { DOOM_STAR }
var doom_star_scene := preload("res://enemies/doom star/DoomStar.tscn")


func _ready():
	spawn_timer.wait_time = DEFAULT_SPAWN_TIME
	spawn_timer.start()
	# Create starting enemies, no dragon
#	for _i in range(starting_enemies):
#		instance_enemy(0)
#	enemies_count = starting_enemies


func instance_enemy(enemy_type):
	var enemy: Enemy
	match enemy_type:
		DOOM_STAR:
			enemy = doom_star_scene.instantiate()
			assert(enemy)
		_:
			print("Wrong enemy")

	get_tree().root.get_node("Main").call_deferred("add_child", enemy)
	# Connect enemy's death signal to the manager
	var err := enemy.connect("death", _on_enemy_death)
#	var err := enemy.connect("death", self, "_on_enemy_death")
	assert(!err)
#	enemy_spawner.spawn_enemy(enemy)
	enemy_spawn_location.progress_ratio = randi()
	enemy.position = enemy_spawn_location.position + player.position

	enemies_count += 1


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
		instance_enemy(0)
