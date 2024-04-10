extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const ACCELERATION = 600
const FRICTION = 1500

var double_jump = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Double Jump
	if (
		Input.is_action_just_pressed("ui_accept")
		and not is_on_floor()
		and double_jump < 1
	):
		velocity.y = JUMP_VELOCITY * .7
		double_jump += 1

	# Handle jump.
	if (
		Input.is_action_just_pressed("ui_accept") 
		and is_on_floor()
	):
		velocity.y = JUMP_VELOCITY
		double_jump = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		#velocity.x = direction * SPEED
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	move_and_slide()
