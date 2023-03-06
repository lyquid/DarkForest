extends Projectile

const DEFAULT_LASER_DISABLE_TIME := 5.0

@onready var disable_timer := $DisableTimer


func _ready():
	disable_timer.wait_time = DEFAULT_LASER_DISABLE_TIME
	disable_timer.start()


func setup(damage_in: int, speed_in: float, direction_in: Vector2) -> Node2D:
	damage = damage_in
	speed = speed_in
	direction = direction_in
	rotation = direction_in.angle()
	return self


func _on_disable_timer_timeout():
	get_tree().queue_delete(self)
