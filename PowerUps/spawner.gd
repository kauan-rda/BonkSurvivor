extends Node2D
"res://PowerUps/FonteDaSorte.tscn"

@export var FonteDaSorte: PackedScene

@onready var timer = $Timer

@export var container_fontes: Node2D

@onready var posicoes_spawn: Array[Node2D] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if container_fontes == null:
		container_fontes = get_parent()
	
	timer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout():
	if FonteDaSorte == null:
		print("Objeto FonteDaSorte Nao definido")
		return
	if posicoes_spawn.is_empty():
		print("Nao ha posicoes definidas para o spawner")
		return
		
	var local_escolhido = posicoes_spawn.pick_random()
	
	var nova_instancia = FonteDaSorte.instantiate()
	nova_instancia.global_position = local_escolhido.global_position
		
	container_fontes.add_child(nova_instancia)
		
	
	for filho in $Posicoes.get_children():
		if filho is Node2D:
			posicoes_spawn.append(filho)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
