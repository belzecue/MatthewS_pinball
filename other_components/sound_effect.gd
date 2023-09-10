extends Node3D

@export var sound: AudioStreamWAV
@export var reset_time = 1.0
@export var score_event := "Sound Trigger Hit"
@onready var audio = $Audio

# Flag to track if area_1 was entered
var entered_area_1 = false


func _ready():
	audio.stream = sound


func _on_area_1_body_entered(_body):
	entered_area_1 = true
	await get_tree().create_timer(reset_time).timeout
	entered_area_1 = false


func _on_area_2_body_entered(_body):
	if entered_area_1:
		entered_area_1 = false
		Score.event(score_event)
		if !Global.mute:
			audio.play()
