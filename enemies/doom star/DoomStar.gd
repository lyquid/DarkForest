extends Enemy

const DEFAULT_DOOMSTAR_DAMAGE := 5
const DEFAULT_DOOMSTAR_HEALTH := 10
const DEFAULT_DOOMSTAR_SPEED := 40.0


func _ready():
	enemy_name = "Doom Star"
	damage = DEFAULT_DOOMSTAR_DAMAGE
	health = DEFAULT_DOOMSTAR_HEALTH
	speed = DEFAULT_DOOMSTAR_SPEED
	animated_sprite.play("idle")
