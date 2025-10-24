extends Area2D

enum Efeitos{
	AUMENTA_VELOCIDADE_PLAYER,
	REDUZ_VELOCIDADE_PLAYER,
	FULL_HEALTH,
	REDUZ_VELOCIDADE_INIMIGOS,
}

@export var efeitosCriados: Array[Efeitos] =[
	Efeitos.AUMENTA_VELOCIDADE_PLAYER,
	Efeitos.REDUZ_VELOCIDADE_PLAYER,
	Efeitos.FULL_HEALTH,
	Efeitos.REDUZ_VELOCIDADE_INIMIGOS,
]

var texto_efeito = "Efeito"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var efeito_sorteado = efeitosCriados.pick_random()
		
		match efeito_sorteado:
			Efeitos.AUMENTA_VELOCIDADE_PLAYER:
				texto_efeito = "DOBRO DE VELOCIDADE POR 5 SEGUNDOS"
				get_tree().call_group("player", "alterar_velocidade",200, 5)
		
			Efeitos.REDUZ_VELOCIDADE_PLAYER:
				texto_efeito = "MAIS DEVAGAR POR 8 SEGUNDOS"
				get_tree().call_group("player", "alterar_velocidade",75, 8)
			
			Efeitos.FULL_HEALTH:
				texto_efeito = "Full health"
				get_tree().call_group("player", "full_health")
			
			Efeitos.REDUZ_VELOCIDADE_INIMIGOS:
				texto_efeito = "Reduz velocidade dos inimigos"
				get_tree().call_group("enemy", "alterar_velocidade",40, 8)
	
		var instanciaTexto = preload("res://EfeitoLabel.tscn").instantiate()
		get_parent().add_child(instanciaTexto)
		instanciaTexto.global_position = self.global_position
		instanciaTexto.setup_texto(texto_efeito, 1.0)
	
		queue_free()
