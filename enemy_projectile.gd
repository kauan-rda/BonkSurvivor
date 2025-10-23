extends Area2D

const SPEED = 250.0
var direction = Vector2.ZERO # A direção será definida pelo inimigo que atirou

func _physics_process(delta):
	# Move o projétil na direção definida
	global_position += direction * SPEED * delta

func _on_body_entered(body):
	# Se atingir o jogador, causa dano e se destrói
	if body.is_in_group("player"):
		body.take_damage()
		queue_free()
