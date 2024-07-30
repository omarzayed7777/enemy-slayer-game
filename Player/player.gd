extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 9.0
var direction
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	PlayerManager.player = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Right", "Left", "Down", "Up")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "1H_Melee_Attack_Slice_Diagonal":
		$PlayerStateMachine/SwordSwingPlayerState.transition("IdlePlayerState")
