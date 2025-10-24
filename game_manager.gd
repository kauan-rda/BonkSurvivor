extends Node

# Carrega a cena da porta que será instanciada
var door_scene = preload("res://enemy_door.tscn")

@onready var door_spawn_timer = $DoorSpawnTimer

# Variável para guardar o tamanho da tela e posicionar as portas
var screen_size

func _ready():
	# Pega o tamanho da viewport (a área visível do jogo) da forma correta
	# CORREÇÃO APLICADA AQUI:
	screen_size = get_viewport().get_visible_rect().size

	# O timer já começa a contar porque marcamos "Autostart"

func _on_door_spawn_timer_timeout():
	# Esta função é chamada a cada X segundos
	print("[DEBUG] GameManager: Criando uma nova porta!")

	# 1. Cria uma nova instância da cena da porta
	var door_instance = door_scene.instantiate()
	%spawn.progress_ratio=randf()
	door_instance.global_position=%spawn.global_position
	add_child(door_instance)
	
