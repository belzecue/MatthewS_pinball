extends AnimatableBody3D

@export var disable_time := 0.5
@onready var visible_wall = $Visible_Wall

@onready var timer = $Timer
var collision_layer_back := collision_layer


func _on_timer_timeout():
	collision_layer = collision_layer_back


func _on_ball_detection_body_entered(_body):
	collision_layer = 0


func _on_ball_detection_body_exited(_body):
	timer.start(disable_time)
