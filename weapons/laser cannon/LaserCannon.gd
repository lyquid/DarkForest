extends Weapon

class_name LaserCannon

const DEFAULT_LASER_CANNON_COOLDOWN_TIME := 0.4
const DEFAULT_LASER_DAMAGE := 10
const DEFAULT_LASER_SPEED := 300.0

@onready var cooldown_timer := $Cooldown
var laser_scene := preload("res://weapons/laser cannon/Laser.tscn")


func _ready():
	manager = get_parent()
	cooldown = DEFAULT_LASER_CANNON_COOLDOWN_TIME
	damage = DEFAULT_LASER_DAMAGE
	speed = DEFAULT_LASER_SPEED
	weapon_name = "Laser cannon"
	cooldown_timer.wait_time = cooldown
	cooldown_timer.start()


func shoot():
	var laser = laser_scene.instantiate().setup(damage, speed, manager.player.get_last_moving_direction())
	laser.position = manager.player.position
	manager.main.add_child(laser)


func _on_cooldown_timeout():
	shoot()
