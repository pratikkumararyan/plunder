extends RigidBody2D

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		body.TakeDamage(30)
	
	$AnimatedSprite2D.hide()
	$CollisionShape2D.set_deferred("disabled", true)
	freeze = true

	var particles = $"Bottle Break Particle Effect/CPUParticles2D"
	particles.emitting = true

	await get_tree().create_timer(particles.lifetime).timeout
	queue_free()
