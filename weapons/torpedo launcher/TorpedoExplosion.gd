extends GPUParticles2D


func _on_delete_timer_timeout():
	queue_free()
