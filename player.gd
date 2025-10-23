extends CharacterBody2D

var health = 3

# --- Constantes de Movimento Ajustadas ---

# A velocidade de caminhada continua lenta
const WALK_SPEED = 100.0

# A gravidade foi um pouco aumentada para o pulo ter mais "peso" na descida
const GRAVITY = 800.0

# NOVAS constantes para o "Bonk" (o antigo dash)
# Força do pulo para cima. É um valor negativo porque o eixo Y é para baixo.
const BONK_JUMP_FORCE = -450.0 
# Força do movimento lateral DURANTE o pulo. Menor que o dash antigo.
const BONK_AIR_SPEED = 300.0 


func _physics_process(delta):
	# 1. Aplicar Gravidade
	# A gravidade é aplicada constantemente, a menos que o personagem esteja no chão.
	if not is_on_floor():		velocity.y += GRAVITY * delta

	# 2. Lógica do "Bonk" (Pulo)
	# A condição agora é simples: o jogador apertou o botão E está no chão?
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		# Aplica a força vertical do pulo imediatamente
		velocity.y = BONK_JUMP_FORCE
		
		# Verifica a direção para o movimento aéreo
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * BONK_AIR_SPEED

	# 3. Lógica de Caminhada (Apenas no Chão)
	# O movimento lateral normal só funciona quando o jogador está no chão.
	# Isso evita que o jogador "deslize" no ar, dando mais controle ao pulo.
	if is_on_floor():
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * WALK_SPEED
	
	# 4. Executar o Movimento
	# A função move_and_slide() aplica todas as mudanças de velocidade.
	move_and_slide()

func take_damage():
	health -= 1
	print("Vida atual: ", health) # Para debug
	if health <= 0:
		print("GAME OVER")
		get_tree().reload_current_scene() # Reinicia a fase
