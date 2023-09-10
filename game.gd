extends Node

@export var tick_times := {
	Global.Mode.BOOT: 0.2,
	Global.Mode.DEMO: 0.5,
}

@onready var ball := $Ball
@onready var ball_start := $BallStart
@onready var camera := $WorldThings/Camera3D
@onready var boot_sound := $WorldThings/BootSound
@onready var serve_sound := $WorldThings/ServeSound
@onready var crash_sound := $WorldThings/CrashSound
@onready var game_lost := $WorldThings/GameLost
@onready var logger := Print.get_logger(PrintScope.GLOBAL)
@onready var glass := $TableStatic/Glass
@onready var serve_light := $Lights/ServeLight
@onready var screen: Screen = $Screen
@onready var tick := $WorldThings/Tick

var resetting := true
var tick_count := 0

func _ready():
	Score.connect("high_score", _on_high_score_run)
	if Global.game_mode == Global.Mode.BOOT:
		boot()
	elif Global.game_mode == Global.Mode.DEMO:
		demo()


func _physics_process(_delta):
	if Input.is_action_just_pressed("restart"):
		ball.move(ball_start.position)


func boot():
	Global.game_mode = Global.Mode.BOOT
	Score.reset()
	screen.set_pattern("Boot")
	tick.start(tick_times[Global.Mode.BOOT])
	tick_count = 0
	if !Global.skip_intro:
		if !Global.mute:
			boot_sound.play()
		await get_tree().create_timer(1).timeout
		screen.text_mode = Screen.TEXT_TYPE.START
		screen.set_pattern("Vortex")
		await get_tree().create_timer(4).timeout
	logger.info("Game Start.")
	Global.game_mode = Global.Mode.PLAYING
	reset()
	serve()


func serve():
	screen.text_mode = Screen.TEXT_TYPE.SERVE
	screen.set_pattern("Flash")
	serve_light.activate()

	if !Global.mute:
		serve_sound.play()
		await get_tree().create_timer(1).timeout
	resetting = false
	ball.move(ball_start.position)
	
	if Score.cur_is_high_score:
		screen.text_mode = Screen.TEXT_TYPE.HIGH_SCORE
		screen.set_pattern("Epic")
	else:
		screen.text_mode = Screen.TEXT_TYPE.SCORE
		screen.set_pattern("Spin")
	serve_light.deactivate()


func demo():
	tick.start(tick_times[Global.Mode.DEMO])
	Score.reset()
	tick_count = 0
	Global.game_mode = Global.Mode.DEMO
	screen.set_pattern("Demo")
	screen.text_mode = Screen.TEXT_TYPE.DEMO


func reset():
	for node in get_tree().get_nodes_in_group("ball_reset"):
		node.reset()


func _input(event):
	if (Global.game_mode == Global.Mode.GAMEOVER or Global.game_mode == Global.Mode.DEMO) and \
		(event is InputEventJoypadButton or event is InputEventKey):
		boot()
	
	if Global.debug_mode and event is InputEventMouseButton and event.pressed and event.button_index == 2:
		var ray_from = camera.project_ray_origin(event.position)
		var ray_to = ray_from + camera.project_ray_normal(event.position) * 1000  # Adjust this based on your scene depth

		# Create the PhysicsRayQueryParameters3D object using the provided utility method.
		var query = PhysicsRayQueryParameters3D.create(ray_from, ray_to)
		query.exclude = [ball.get_rid(), glass.get_rid()]  # Exclude the ball from the raycast.
		query.collide_with_bodies = true  # Ensure we're colliding with bodies (this is default but just being explicit).

		var result = camera.get_world_3d().direct_space_state.intersect_ray(query)
		
		# Check if we have an intersection (i.e., if the dictionary is not empty)
		if result and result.has("position"):
			var ball_position = result["position"]
			ball_position.y += 0.25  # Adjust for the ball's height
			ball.move(ball_position)


func _on_ball_out_of_bounds(_body):
	if !resetting:
		resetting = true
		logger.error("Ball out of bounds! Resetting!")
		serve()


func _on_gutter_body_entered(_body):
	if !resetting:
		resetting = true
		if !Global.mute:
			logger.info("Ball entered gutter.")
			crash_sound.play()
			await get_tree().create_timer(2).timeout
		Score.add_ball()
		if Score.is_game_over():
			Global.game_mode = Global.Mode.GAMEOVER
			screen.text_mode = Screen.TEXT_TYPE.GAMEOVER
			await get_tree().create_timer(10).timeout
			if Global.game_mode == Global.Mode.GAMEOVER:
				reset()
				demo()
		else:
			reset()
			serve()


func _on_high_score_run():
	screen.text_mode = Screen.TEXT_TYPE.HIGH_SCORE
	screen.set_pattern("Epic")


func _on_tick_timeout():
	tick_count += 1
	match Global.game_mode:
		Global.Mode.BOOT:
			for node in get_tree().get_nodes_in_group("boot"):
				node.tick(tick_count)
		Global.Mode.DEMO:
			for node in get_tree().get_nodes_in_group("demo"):
				node.tick(tick_count)
		_:
			pass
