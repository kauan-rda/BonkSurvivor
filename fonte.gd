extends Area2D

enum Efeitos{
	AUMENTA_VELOCIDADE_PLAYER,
	REDUZ_VELOCIDADE_PLAYER,
	REDUZ_BONK_TIMER,
	FULL_HEALTH,
	REDUZ_VELOCIDADE_INIMIGOS,
	AUMENTA_BONK_TIMER
}

@export var efeitosCriados: Array[Efeitos] =[
	Efeitos.AUMENTA_VELOCIDADE_PLAYER,
	Efeitos.REDUZ_VELOCIDADE_PLAYER,
	Efeitos.REDUZ_BONK_TIMER,
	Efeitos.FULL_HEALTH,
	Efeitos.REDUZ_VELOCIDADE_INIMIGOS,
	Efeitos.AUMENTA_BONK_TIMER
]

var texto_efeito = "Efeito"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var efeito_sorteado = efeitosCriados.pick_random()
		
		match efeito_sorteado:
			Efeitos.AUMENTA_VELOCIDADE_PLAYER:
				texto_efeito = "Aumenta a velocidade do player"
		
			Efeitos.REDUZ_VELOCIDADE_PLAYER:
				texto_efeito = "Reduz velocidade do player"
			
			Efeitos.REDUZ_BONK_TIMER:
				texto_efeito = "Reduz Bonk timer"
			
			Efeitos.FULL_HEALTH:
				texto_efeito = "Full health"
			
			Efeitos.REDUZ_VELOCIDADE_INIMIGOS:
				texto_efeito = "Reduz velocidade dos inimigos"
			
			Efeitos.AUMENTA_BONK_TIMER:
				texto_efeito = "Aumenta Bonk Timer"
	
		var instanciaTexto = preload("res://EfeitoLabel.tscn").instantiate()
		get_parent().add_child(instanciaTexto)
		instanciaTexto.global_position = self.global_position
		instanciaTexto.setup_texto(texto_efeito, 1.0)
	
		queue_free()
