class_name killableEnemy extends CharacterBody2D

@onready var ray_cast = $RayCast2D

@export var speed = 300
var direction = 1
var canSwitch = true

func _physics_process(delta: float) -> void:
	if !ray_cast.is_colliding() and canSwitch:
		direction *= -1
		canSwitch = false
	else:
		canSwitch = true

	if direction < 0 :
		velocity.x = speed * -1.0
		ray_cast.target_position = Vector2(-270, 250)
	else:
		velocity.x = speed * 1.0
		ray_cast.target_position = Vector2(270, 250)

	move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.killPlayer()
	
func kill_enemy() :
	GameManager.coins += 100
	print(GameManager.coins)
	queue_free()
