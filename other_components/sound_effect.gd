extends Node3D

@export var sound: AudioStreamWAV
@onready var audio = $Audio
@export var reset_time = 1.0

# Flag to track if area_1 was entered
var entered_area_1 = false


func _ready():
	audio.stream = sound


func _on_area_1_body_entered(_body):
	entered_area_1 = true
	await get_tree().create_timer(reset_time).timeout
	entered_area_1 = false


func _on_area_2_body_entered(_body):
	if entered_area_1 and !Global.mute:
		audio.play()
		entered_area_1 = false
