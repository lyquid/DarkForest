extends Weapon

class_name Railgun

const DEFAULT_RAILGUN_COOLDOWN_TIME := 2.0
const DEFAULT_HVP_DAMAGE := 20
const DEFAULT_HVP_PIERCING_POWER := 30
const DEFAULT_HVP_SPEED := 700.0

@onready var cooldown_timer := $Cooldown
@onready var sprite := $Sprite2D
@onready var shoot_particles := $Sprite2D/ShootParticles
var hvp_scene := preload("res://weapons/railgun/HVP.tscn")
var piercing_power := DEFAULT_HVP_PIERCING_POWER
var ready_to_shoot := false
var target: Enemy = null


func _ready():
	manager = get_parent()
	cooldown = DEFAULT_RAILGUN_COOLDOWN_TIME
	damage = DEFAULT_HVP_DAMAGE
	speed = DEFAULT_HVP_SPEED
	weapon_name = "Railgun"
	cooldown_timer.wait_time = cooldown
	cooldown_timer.start()


func _process(_delta):
	if is_instance_valid(target):
		sprite.look_at(target.global_position)
		if ready_to_shoot:
			shoot()
	else:
		request_target()


func request_target():
	if manager.player.are_enemies_available():
		target = manager.player.get_nearest_enemy()
	else:
		target = null


# Always check if we have a valid target before shooting!
func shoot():
	var hvp = hvp_scene.instantiate().setup(damage, speed, (target.global_position - global_position).normalized(), piercing_power)
	hvp.position = manager.player.position
	manager.main.add_child(hvp)
	shoot_particles.emitting = true
	ready_to_shoot = false
	cooldown_timer.start()


func _on_cooldown_timeout():
	ready_to_shoot = true
