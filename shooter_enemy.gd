extends CharacterBody2D

# Carrega a cena do projétil que acabamos de criar
var projectile_scene = preload("res://enemy_projectile.tscn")
var player = null

@onready var shoot_timer = $ShootTimer

func _ready():
	# Continua encontrando o jogador para saber para onde mirar
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	# Este inimigo não se move, então não há código de movimento aqui.
	# Apenas chamamos move_and_slide() para que a física funcione.
	move_and_slide()

func _on_shoot_timer_timeout():
	# Esta função é chamada toda vez que o Timer zera
	if player:
		var projectile = projectile_scene.instantiate()

		# A direção é calculada no momento do tiro
		var direction = (player.global_position - global_position).normalized()

		# Configura o projétil
		projectile.global_position = global_position
		projectile.direction = direction

		# Adiciona o projétil à cena principal do jogo
		get_parent().add_child(projectile)
