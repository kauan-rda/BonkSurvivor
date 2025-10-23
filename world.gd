extends Node2D

func spawn_fonte():
	var fonte = preload("res://fonte.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	fonte.global_position = %PathFollow2D.global_position
	add_child(fonte)


func _on_timer_timeout():
	spawn_fonte()
