extends KinematicBody2D

export var ACCEL = 10
export var DECEL = 25
export var gravity = 400
export var SPEED = 200.0
export var JUMP_VELOCITY = -300.0

var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if is_on_wall(): velocity.y = clamp(velocity.y, JUMP_VELOCITY, 100)
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x += direction * ACCEL + velocity.x * delta
		velocity.x = clamp(velocity.x, -1 * SPEED, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide(velocity, Vector2(0, -1))
