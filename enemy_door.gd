extends Area2D

# Carrega os inimigos que a porta pode criar
var melee_enemy_scene = preload("res://enemy.tscn")
var shooter_enemy_scene = preload("res://shooter_enemy.tscn")
var enemy_types = []

var enemies_to_spawn = 3 # Quantos inimigos esta porta vai gerar

@onready var spawn_timer = $SpawnTimer
@onready var lifetime_timer = $LifetimeTimer

func _ready():
	# Adiciona os tipos de inimigos à lista para sorteio
	enemy_types = [melee_enemy_scene, shooter_enemy_scene]

	# Inicia os timers
	spawn_timer.start()
	lifetime_timer.start()

func _on_spawn_timer_timeout():
	if enemies_to_spawn > 0:
		spawn_enemy()
		enemies_to_spawn -= 1
	else:
		# Se já gerou todos, se destrói
		queue_free()

func spawn_enemy():
	var chosen_enemy = enemy_types.pick_random() # Sorteia um inimigo
	var enemy_instance = chosen_enemy.instantiate()
	enemy_instance.global_position = global_position
	get_parent().add_child(enemy_instance)

func _on_lifetime_timer_timeout():
	# Se o tempo de vida acabar, a porta se destrói de qualquer jeito
	queue_free()
