class_name Fireball
extends Area2D

@export var move_speed = 900.0

@onready var anim = $AnimatedSprite2D

var direction = 1

func _process(delta: float) -> void:
	if direction == -1:
		anim.flip_h = true
	else :
		anim.flip_h = false
	position.x += move_speed * delta * direction


func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body is killableEnemy:
		body.kill_enemy()
		body.queue_free()
	queue_free()
