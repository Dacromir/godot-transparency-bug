extends KinematicBody

export var speed = 5
export var mouse_sensitivity = 5

var velocity = Vector3.ZERO
var input_active = false
var mouse_look = false


func _ready():
	mouse_look = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Toggle mouse look
	if Input.is_action_just_pressed("camera_pan"):
		if mouse_look:
			mouse_look = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			mouse_look = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Pan the camera
	if mouse_look and (event is InputEventMouseMotion):
		var mouse_motion = event.relative
		rotation.y += -deg2rad(mouse_motion.x * mouse_sensitivity / 10)
		rotation.x = clamp(rotation.x - deg2rad(mouse_motion.y * mouse_sensitivity / 10), deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)

func get_input(delta):
	input_active = false
	velocity = Vector3.ZERO
	if Input.is_action_pressed("move_f"):
		velocity += -transform.basis.z
		input_active = true
	elif Input.is_action_pressed("move_b"):
		velocity += transform.basis.z
		input_active = true
	
	if Input.is_action_pressed("move_l"):
		velocity += -transform.basis.x
		input_active = true
	elif Input.is_action_pressed("move_r"):
		velocity += transform.basis.x
		input_active = true
	
	if Input.is_action_pressed("move_u"):
		velocity += transform.basis.y
		input_active = true
	elif Input.is_action_pressed("move_d"):
		velocity += -transform.basis.y
		input_active = true
	
	if input_active:
		velocity = velocity.normalized() * speed

