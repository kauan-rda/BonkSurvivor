extends Area2D

const SPEED = 250.0
var direction = Vector2.ZERO

func _physics_process(delta):
	global_position += direction * SPEED * delta

func _on_body_entered(body):
	# CORREÇÃO: O nome do grupo deve ser "player" (minúsculo).
	if body.is_in_group("player"):
		body.take_damage()
		queue_free()
