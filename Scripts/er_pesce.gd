extends CharacterBody2D


@export var speed = 100.0
@export var jump = -400.0
@export var health = 300 
@export var player : CharacterBody2D
var aoe_duration : Timer
var attack_timer : Timer
var phase_1 = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func initialize(attack,aoe):
	attack_timer = attack 
	aoe_duration = aoe

func _physics_process(delta):
	if health <= 0:
		phase_1 = false
		health = 300
	if phase_1:
		var direction = player.get_position()
		if not is_on_floor():
			velocity.y += gravity * delta 
		else :
			velocity.y = jump
		if direction :
			velocity.x = position.direction_to(direction).x * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	else :
		attack_timer.start(5)
		set_physics_process(false)
	move_and_slide()
	$AnimatedSprite2D.play("Fish")

func get_phase():
	return phase_1
