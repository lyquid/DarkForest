extends Weapon

class_name LaserCannon

const DEFAULT_LASER_CANNON_COOLDOWN_TIME := 0.4
const DEFAULT_LASER_DAMAGE := 10
const DEFAULT_LASER_SPEED := 300.0

@onready var main := get_tree().root.get_node("Main")
@onready var player := get_tree().root.get_node("Main/Player")
@onready var cooldown_timer := $Cooldown
var laser_scene := preload("res://weapons/laser cannon/Laser.tscn")
var cooldown := DEFAULT_LASER_CANNON_COOLDOWN_TIME

func _ready():
	damage = DEFAULT_LASER_DAMAGE
	speed = DEFAULT_LASER_SPEED
	weapon_name = "Laser cannon"
	cooldown_timer.wait_time = cooldown
	cooldown_timer.start()


func shoot():
	var laser = laser_scene.instantiate().setup(damage, speed, player.get_last_moving_direction())
	laser.position = player.position
	main.call_deferred("add_child", laser)


func _on_cooldown_timeout():
	shoot()
