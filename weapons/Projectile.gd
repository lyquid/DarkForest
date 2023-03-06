extends Area2D

class_name Projectile

var damage: int
var direction: Vector2
var speed: float


func _process(delta):
	position += speed * delta * direction


func _on_body_entered(body):
	body.hit(damage)
	get_tree().queue_delete(self)


func _on_disable_timer_timeout():
	get_tree().queue_delete(self)
