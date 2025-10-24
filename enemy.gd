extends CharacterBody2D

var SPEED = 80.0
var player = null

func _ready():
	# Encontra o jogador na cena assim que o inimigo é criado
	player = get_tree().get_first_node_in_group("player")
	
	if player == null:
		print("[DEBUG] INIMIGO DE PERSEGUIÇÃO: Não encontrei o jogador!")

func _physics_process(delta):
	# Só tenta se mover se o jogador foi encontrado com sucesso
	if player:
		# Calcula a direção até o jogador e se move
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()

	# Checar se colidiu com o jogador
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if collision.get_collider().is_in_group("player"):
			collision.get_collider().take_damage()
			queue_free() # Inimigo se destrói ao causar dano

func alterar_velocidade(quantidade, timer_time):
	SPEED = quantidade
	print("Velocidade aumentada para: ", SPEED)
	# Cria um timer de 5 segundos que, ao terminar, chama a função de reset
	get_tree().create_timer(timer_time).timeout.connect(alterar_velocidade)

func _resetar_velocidade():
	# CORREÇÃO: Usando WALK_SPEED e o valor original guardado
	SPEED = 80
	print("Velocidade restaurada para: ", SPEED)
