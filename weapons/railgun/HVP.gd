extends Projectile

const DEFAULT_HVP_DISABLE_TIME := 5.0

@onready var disable_timer := $DisableTimer
var piercing_power: int


func _ready():
	disable_timer.wait_time = DEFAULT_HVP_DISABLE_TIME
	disable_timer.start()


func setup(damage_in: int, speed_in: float, direction_in: Vector2, piercing_power_in: int) -> Node2D:
	damage = damage_in
	speed = speed_in
	direction = direction_in
	piercing_power = piercing_power_in
	return self


func _on_body_entered(body):
	body.hit(damage)
	piercing_power -= 1
	if piercing_power <= 0:
		get_tree().queue_delete(self)
