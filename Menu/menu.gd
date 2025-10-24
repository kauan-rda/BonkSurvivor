extends Control

func _ready() -> void:
	pass


func _on_button_pressed() -> void:
	var _game: bool = get_tree().change_scene_to_file("res://world.tscn")

func _on_button_3_pressed() -> void:
	get_tree().quit()
