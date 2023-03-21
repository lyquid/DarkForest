extends Weapon

class_name TorpedoLauncher

const DEFAULT_TORPEDO_LAUNCHER_COOLDOWN_TIME := 0.2
const DEFAULT_TORPEDO_DAMAGE := 10
# Torpedo bays in order of shooting
enum Bay { TOP_LEFT, BOTTOM_RIGHT, BOTTOM_LEFT, TOP_RIGHT }

@onready var cooldown_timer := $Cooldown
var torpedo_scene := preload("res://weapons/torpedo launcher/Torpedo.tscn")
var current_bay := Bay.TOP_LEFT


func _ready():
	manager = get_parent()
	cooldown = DEFAULT_TORPEDO_LAUNCHER_COOLDOWN_TIME
	damage = DEFAULT_TORPEDO_DAMAGE
	weapon_name = "Torpedo launcher"
	cooldown_timer.wait_time = cooldown
	cooldown_timer.start()


func shoot():
	var torpedo: Projectile = torpedo_scene.instantiate().setup(damage)
	match current_bay:
		Bay.TOP_LEFT:
			torpedo.position = Vector2(-10.0, -10.0)
			torpedo.direction = Vector2(-1.0, 0.0)
			torpedo.rotation_degrees = 180.0
			current_bay = Bay.BOTTOM_RIGHT
		Bay.BOTTOM_RIGHT:
			torpedo.position = Vector2(10.0, 10.0)
			torpedo.direction = Vector2(1.0, 0.0)
			current_bay = Bay.BOTTOM_LEFT
		Bay.BOTTOM_LEFT:
			torpedo.position = Vector2(-10.0, 10.0)
			torpedo.direction = Vector2(-1.0, 0.0)
			torpedo.rotation_degrees = 180.0
			current_bay = Bay.TOP_RIGHT
		Bay.TOP_RIGHT:
			torpedo.position = Vector2(10.0, -10.0)
			torpedo.direction = Vector2(1.0, 0.0)
			current_bay = Bay.TOP_LEFT
	# we add the torpedo to the player so it stays by the player until ignition
	manager.player.add_child(torpedo)


func _on_cooldown_timeout():
	shoot()
