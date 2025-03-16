extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -1900.0

@export var FIREBALL : PackedScene
@export var run_multiplier = 1

@onready var fireball_spawn_point_right = %FireSpawnPointRight
@onready var fireball_spawn_point_left = %FireSpawnPointLeft
@onready var fireball_container = %fireballs
@onready var anim = $AnimatedSprite2D
@onready var respawn_point = %SpawnPoint
@onready var heart = %heart

var health_list : Array[TextureRect]
var health = 3


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		var shooter = FIREBALL.instantiate() as Fireball
		if anim.flip_h == true:
			shooter.global_position = fireball_spawn_point_left.global_position
			shooter.direction = -1
		else :
			shooter.global_position = fireball_spawn_point_right.global_position
		
		fireball_container.add_child(shooter)
		
	#increases speed of player when you hold shift
	if Input.is_action_just_pressed("run"):
		run_multiplier = 1.5
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED * run_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * run_multiplier)
	# Handles direction the player faces
	if velocity.x < 0:
		anim.flip_h = true
	if velocity.x > 0:
		anim.flip_h = false
	#Handles walking or idle animation
	if velocity.x != 0:
		anim.play("walk")
	else:
		anim.play("idle")
	
	move_and_slide()
	
func _ready() -> void:
	var hearts_present = $heart/HBoxContainer
	for child in heart.get_childern():
		health_list.append(child)
	print(health_list)
		
		
func take_damage():
	if health > 0:
		health -= 1
		update_heart_display()
		
func update_heart_display():
	for i in range (health_list.size()):
		health_list[i].visible = i < health
		
	#if health <= 0 :
		#alive = false
		#killplayer()
		
	
	
func killPlayer():
	position = respawn_point.position
	anim.flip_h = false
	
func _on_death_zone_body_entered(body: Node2D) -> void:
	health -= 1
	if health <= 0:
		killPlayer()
