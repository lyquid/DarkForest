extends Projectile

const DEFAULT_LASER_DISABLE_TIME := 5.0

@onready var disable_timer := $DisableTimer


func _ready():
	disable_timer.wait_time = DEFAULT_LASER_DISABLE_TIME
	disable_timer.start()
	animated_sprite.play("default")


func setup(damage_in: int, speed_in: float, direction_in: Vector2) -> Projectile:
	damage = damage_in
	speed = speed_in
	direction = direction_in
	rotation = direction_in.angle()
	return self
