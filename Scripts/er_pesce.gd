extends CharacterBody2D


@export var speed = 100.0
@export var jump = -400.0
@onready var player = $"../Player"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func set_player(node):
	player = node

func _physics_process(delta):
	var direction : Vector2 = player.get_position()
	if not is_on_floor():
		velocity.y += gravity * delta 
	else :
		velocity.y = jump
	if direction:
		velocity.x = position.direction_to(direction).x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()
