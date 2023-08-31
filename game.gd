extends Node

# Flippers and plunger references
@onready var flipper_l = $PlayerElements/FlipperL
@onready var flipper_r = $PlayerElements/FlipperR
@onready var plunger = $PlayerElements/Plunger
@onready var ball = $Ball
@onready var ball_start = $BallStart
@onready var camera = $WorldThings/Camera3D
@onready var boot_sound = $WorldThings/BootSound
@onready var serve_sound = $WorldThings/ServeSound


func _ready():
	if !Global.skip_intro:
		if !Global.mute:
			boot_sound.play()
		await get_tree().create_timer(5).timeout
	serve()


func _physics_process(delta):
	if Input.is_action_just_pressed("restart"):
		ball.position = ball_start.position
		ball.linear_velocity = Vector3.ZERO


func serve():
	if !Global.mute:
		serve_sound.play()
	if !Global.skip_intro:
		await get_tree().create_timer(1).timeout
	ball.move(ball_start.position)


func _input(event):
	if Global.debug_mode and event is InputEventMouseButton and event.pressed:
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
	serve()
