extends CharacterBody2D


const normal_speed = 60.0
const dash_speed  = 800.0
const dash_length = .1
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var dash = $Dash

func player_animations():
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("right")
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("left")
	if Input.is_action_pressed("ui_jump"):
		$AnimatedSprite2D.play("jump")
	if Input.is_action_pressed("ui_dash") and Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("dashLeft")
	if Input.is_action_pressed("ui_dash") and Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("dashRight")
	
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_dash"):
		dash.start_dash(dash_length)
	var speed = dash_speed if dash.is_dashing() else normal_speed
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	player_animations()

func _process(delta):
	if Input.is_mouse_button_pressed(1):
		$Area2D/CollisionShape2D_right.disabled = false
		$AnimatedSprite2D.play("attackRight")
	elif Input.is_mouse_button_pressed(1) and Input.is_action_pressed("ui_left"):
		$Area2D/CollisionShape2D_left.disabled = false
		$AnimatedSprite2D.play("attackLeft")
	else:
		$Area2D/CollisionShape2D_right.disabled = true
		$Area2D/CollisionShape2D_left.disabled = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("Hit"):
		body.take_damage()
	else:
		pass
