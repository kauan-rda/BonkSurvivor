extends CharacterBody2D

var health = 3
const WALK_SPEED = 100.0
const GRAVITY = 980.0

# Novas constantes e variáveis para o Dash
const DASH_SPEED = 600.0
const DASH_DURATION = 0.15 # segundos
const DASH_COOLDOWN = 0.5 # segundos

var is_dashing = false
var can_dash = true

# Referências para os nós Timer
@onready var dash_timer = $DashTimer
@onready var dash_cooldown_timer = $DashCooldownTimer

func _physics_process(delta):
	# Não fazer nada se estiver dando dash
	if is_dashing:
		move_and_slide()
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Input de movimento
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * WALK_SPEED

	# Input do Dash (Barra de espaço por padrão)
	if Input.is_action_just_pressed("ui_accept") and can_dash and direction != 0:
		start_dash(direction)

	move_and_slide()

func start_dash(direction):
	is_dashing = true
	can_dash = false
	velocity.x = direction * DASH_SPEED
	velocity.y = -150 # Um pequeno pulo para o dash ficar mais legal
	dash_timer.start(DASH_DURATION)
	dash_cooldown_timer.start(DASH_COOLDOWN)

func _on_dash_timer_timeout():
	is_dashing = false
	velocity.x = 0 # Para o movimento abruptamente no final do dash

func _on_dash_cooldown_timer_timeout():
	can_dash = true

func take_damage():
	health -= 1
	print("Vida atual: ", health) # Para debug
	if health <= 0:
		print("GAME OVER")
		get_tree().reload_current_scene() # Reinicia a fase
