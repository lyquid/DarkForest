extends Enemy

const DEFAULT_REDDOOMSTAR_DAMAGE := 5
const DEFAULT_REDDOOMSTAR_HEALTH := 100
const DEFAULT_REDDOOMSTAR_SPEED := 20.0


func _ready():
	enemy_name = "Red Doom Star"
	damage = DEFAULT_REDDOOMSTAR_DAMAGE
	health = DEFAULT_REDDOOMSTAR_HEALTH
	speed = DEFAULT_REDDOOMSTAR_SPEED
	animated_sprite.play("idle")
