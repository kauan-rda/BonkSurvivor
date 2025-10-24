extends Label

@onready var timer = %Timer

var fluctuation = 50.0

func setup_texto(texto_efeito: String, duracao: float = 1.0):
	set_text(texto_efeito)
	timer.wait_time = duracao
	timer.start()

func _process(delta: float):
	global_position.y -= fluctuation * delta
	var timeleft = timer.time_left
	if timeleft < 0.3:
		modulate.a = timeleft / 0.3


func _on_timer_timeout() -> void:
	queue_free()
