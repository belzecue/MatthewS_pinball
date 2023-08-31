extends Node

# Flippers and plunger references
@onready var flipper_l = $PlayerElements/FlipperL
@onready var flipper_r = $PlayerElements/FlipperR
@onready var plunger = $PlayerElements/Plunger
@onready var ball = $Ball
@onready var ball_start = $BallStart
@onready var camera = $Camera3D

# Other settings
@export var debug_mode := false

# Flipper settings
@export var flipper_rotation_speed := 2.5  # Determines the speed of flipper rotation
@export var flipper_max_rotation := -45.0  # Maximum rotation in degrees
@export var flipper_min_rotation := 0.0    # Resting rotation

# Plunger settings
@export var plunger_push_speed := 10.0     # Speed when the plunger releases
@export var plunger_pull_speed := 2.0      # Speed when the plunger pulls back
@export var plunger_max_pullback := 2.0    # Maximum units the plunger can pull back
@export var plunger_current_pullback := 0.0  # Track current pullback
var plunger_start_position: Vector3        # To store the initial position of the plunger


func _ready():
	# Ensure initial states are correct
	flipper_l.rotation_degrees.y = flipper_min_rotation
	flipper_r.rotation_degrees.y = flipper_min_rotation
	plunger_start_position = plunger.position


func _physics_process(delta):
	if Input.is_action_just_pressed("restart"):
		ball.position = ball_start.position
		ball.linear_velocity = Vector3.ZERO
	
	# Handle flippers
	if Input.is_action_pressed("LFlipper"):
		flipper_l.rotation_degrees.y = lerp(flipper_l.rotation_degrees.y, -flipper_max_rotation, flipper_rotation_speed * delta)
	else:
		flipper_l.rotation_degrees.y = lerp(flipper_l.rotation_degrees.y, -flipper_min_rotation, flipper_rotation_speed * delta)
	
	if Input.is_action_pressed("RFlipper"):
		flipper_r.rotation_degrees.y = lerp(flipper_r.rotation_degrees.y, flipper_max_rotation, flipper_rotation_speed * delta)
	else:
		flipper_r.rotation_degrees.y = lerp(flipper_r.rotation_degrees.y, flipper_min_rotation, flipper_rotation_speed * delta)
	
	# Handle plunger
	if Input.is_action_pressed("Plunger") and plunger_current_pullback < plunger_max_pullback:
		plunger_current_pullback += plunger_pull_speed * delta
	elif not Input.is_action_pressed("Plunger") and plunger_current_pullback > 0:
		# Compute proportional return speed
		var return_speed = plunger_push_speed * (plunger_current_pullback / plunger_max_pullback)
		plunger_current_pullback -= return_speed * delta
	
	# Don't overshoot.
	if plunger_current_pullback < 0:
		plunger_current_pullback = 0
	
	# Apply the plunger position offset based on the current pullback
	plunger.position.z = plunger_start_position.z + plunger_current_pullback


func _input(event):
	if debug_mode and event is InputEventMouseButton and event.pressed:
		var ray_from = camera.project_ray_origin(event.position)
		var ray_to = ray_from + camera.project_ray_normal(event.position) * 1000  # Adjust this based on your scene depth

		# Create the PhysicsRayQueryParameters3D object using the provided utility method.
		var query = PhysicsRayQueryParameters3D.create(ray_from, ray_to)
		query.exclude = [ball.get_rid()]  # Exclude the ball from the raycast.
		query.collide_with_bodies = true  # Ensure we're colliding with bodies (this is default but just being explicit).

		var result = camera.get_world_3d().direct_space_state.intersect_ray(query)
		
		# Check if we have an intersection (i.e., if the dictionary is not empty)
		if result and result.has("position"):
			var ball_position = result["position"]
			ball_position.y += 0.25  # Adjust for the ball's height
			ball.move(ball_position)


func _on_ball_out_of_bounds(_body):
	ball.move(ball_start.position)
