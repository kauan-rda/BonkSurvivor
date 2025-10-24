# SCRIPT PARA: shooter_enemy.gd

extends CharacterBody2D

var projectile_scene = preload("res://enemy_projectile.tscn")
var player = null

@onready var shoot_timer = $ShootTimer

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	move_and_slide()

func _on_shoot_timer_timeout():
	if player:
		var projectile = projectile_scene.instantiate()
		var direction = (player.global_position - global_position).normalized()
		projectile.global_position = global_position
		projectile.direction = direction
		get_parent().add_child(projectile)
