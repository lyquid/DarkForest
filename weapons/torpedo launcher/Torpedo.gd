extends Projectile

const DEFAULT_TORPEDO_ACCELERATION := 200.0
const DEFAULT_TORPEDO_DISABLE_TIME := 12.0

@onready var main := get_tree().root.get_node("Main")
@onready var player := get_tree().root.get_node("Main/Player")
@onready var disable_timer := $DisableTimer
@onready var ignition_timer := $IgnitionTimer
var acceleration := DEFAULT_TORPEDO_ACCELERATION
var ignited := false
var target: Enemy = null


func _ready():
	disable_timer.wait_time = DEFAULT_TORPEDO_DISABLE_TIME
	disable_timer.start()
	ignition_timer.start()
	animated_sprite.play("deploy")


func _process(delta):
	if ignited:
		speed += acceleration * delta
		position += speed * delta * direction
		if is_instance_valid(target):
			direction = (target.position - position).normalized()
			look_at(target.global_position)


func setup(damage_in: int) -> Projectile:
	damage = damage_in
	return self


func _on_ignition_timer_timeout():
	animated_sprite.play("ignition")


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "ignition":
		animated_sprite.play("traveling")
		# activate the radar
		$Radar/CollisionPolygon2D.disabled = false
		if $Radar.has_overlapping_bodies():
			target = $Radar.get_overlapping_bodies()[0]
		# player's velocity, so we start at the same speed (inertia!)
		speed = abs(player.velocity.x)
		# save the global position for later
		var current_gposition := global_position
		# detach the node from the player
		player.remove_child(self)
		# add the node to "main"
		main.add_child(self)
		# restore the position
		position = current_gposition
		# to the moon!!
		ignited = true


func _on_radar_body_entered(body: Enemy):
	if not is_instance_valid(target):
		target = body