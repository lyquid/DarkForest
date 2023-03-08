extends Area2D

class_name Projectile

var damage: int
var direction: Vector2
var speed: float


func _process(delta):
	position += speed * delta * direction


func _on_body_entered(body):
	body.hit(damage)
	queue_free()


func _on_disable_timer_timeout():
	queue_free()
