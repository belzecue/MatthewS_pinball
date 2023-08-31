extends AnimatableBody3D
@onready var sound = $Sound

@export var push_speed := 10.0
@export var pull_speed := 2.0
@export var max_pullback := 2.0
var current_pullback := 0.0
var start_position: Vector3


func _ready():
	start_position = position


func _physics_process(delta):
	if Global.tilt:
		return
	if Input.is_action_pressed("Plunger") and current_pullback < max_pullback:
		current_pullback += pull_speed * delta
	elif not Input.is_action_pressed("Plunger") and current_pullback > 0:
		var return_speed = push_speed * (current_pullback / max_pullback)
		current_pullback -= return_speed * delta
	
	if Input.is_action_just_released("Plunger"):
		sound.play()
	
	if current_pullback < 0:
		current_pullback = 0

	position.z = start_position.z + current_pullback
