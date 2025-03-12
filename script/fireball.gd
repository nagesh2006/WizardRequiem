extends CharacterBody2D

@export var SPEED = 2000

var direction : float
var pos : Vector2

func _ready() -> void:
	global_position = pos
	
func _physics_process(delta: float) -> void:
	
	
	velocity = Vector2(SPEED, 0).rotated(direction)
	# Call the move_and_slide() function without arguments
	move_and_slide()
