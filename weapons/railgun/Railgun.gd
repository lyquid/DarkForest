extends Weapon

class_name Railgun

const DEFAULT_RAILGUN_COOLDOWN_TIME := 0.4
const DEFAULT_HVP_DAMAGE := 50
const DEFAULT_HVP_PIERCING_POWER := 60
const DEFAULT_HVP_SPEED := 700.0

@onready var main := get_tree().root.get_node("Main")
@onready var player := get_tree().root.get_node("Main/Player")
@onready var cooldown_timer := $Cooldown
@onready var sprite := $Sprite2D
@onready var shoot_particles := $Sprite2D/ShootParticles
var hvp_scene := preload("res://weapons/railgun/HVP.tscn")
var cooldown := DEFAULT_RAILGUN_COOLDOWN_TIME
var piercing_power := DEFAULT_HVP_PIERCING_POWER
var target = null


func _ready():
	damage = DEFAULT_HVP_DAMAGE
	speed = DEFAULT_HVP_SPEED
	weapon_name = "Railgun"
	cooldown_timer.wait_time = cooldown
	cooldown_timer.start()
	target = request_target()


func _process(_delta):
	if is_instance_valid(target):
		sprite.look_at(target.global_position)


func request_target() -> Enemy:
	if player.are_enemies_available():
		return player.get_nearest_enemy()
	else:
		return null


func shoot():
	if is_instance_valid(target):
		var hvp = hvp_scene.instantiate().setup(damage, speed, (target.global_position - global_position).normalized(), piercing_power)
		hvp.position = player.position
		main.add_child(hvp)
		shoot_particles.emitting = true
	
	target = request_target()


func _on_cooldown_timeout():
	shoot()
