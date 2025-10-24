extends CharacterBody2D

var health = 3
var WALK_SPEED = 100.0 # Mudamos de 'const' para 'var' para poder ser alterada
const GRAVITY = 800.0
const BONK_JUMP_FORCE = -450.0 
const BONK_AIR_SPEED = 300.0 

# Uma "flag" para saber se o jogador pode tomar dano
var is_invincible = false
# Referência para o nosso novo timer
@onready var invincibility_timer = $InvincibilityTimer
# Variável para guardar a velocidade original antes de qualquer power-up
var original_walk_speed = WALK_SPEED

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = BONK_JUMP_FORCE
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * BONK_AIR_SPEED

	if is_on_floor():
		var direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * WALK_SPEED
	
	move_and_slide()

func take_damage():
	if is_invincible:
		return

	health -= 1
	is_invincible = true
	invincibility_timer.start()
	print("Vida atual: ", health)
	
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1,1,1,0.5), 0.1)
	tween.tween_property($Sprite2D, "modulate", Color(1,1,1,1), 0.1)
	tween.set_loops(2)

	if health <= 0:
		print("GAME OVER")
		get_tree().reload_current_scene()

func _on_invincibility_timer_timeout():
	is_invincible = false

# --- Novas Funções Corrigidas ---

func aumentar_velocidade(quantidade):
	# CORREÇÃO: Usando a variável WALK_SPEED
	WALK_SPEED += quantidade
	print("Velocidade aumentada para: ", WALK_SPEED)
	
	# Cria um timer de 5 segundos que, ao terminar, chama a função de reset
	get_tree().create_timer(5.0).timeout.connect(_resetar_velocidade)

func _resetar_velocidade():
	# CORREÇÃO: Usando WALK_SPEED e o valor original guardado
	WALK_SPEED = original_walk_speed
	print("Velocidade restaurada para: ", WALK_SPEED)
