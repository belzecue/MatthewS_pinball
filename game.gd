extends Node

# Flippers and plunger references
@onready var flipper_l = $PlayerElements/FlipperL
@onready var flipper_r = $PlayerElements/FlipperR
@onready var plunger = $PlayerElements/Plunger
@onready var ball = $Ball
@onready var ball_start = $BallStart

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


func _on_ball_out_of_bounds(_body):
	ball.position = ball_start.position
	ball.linear_velocity = Vector3.ZERO
