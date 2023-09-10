extends Node3D

@export var flip_sound: AudioStreamWAV
@export var score_event := "Fuel Spinner"
@onready var animation_player = $AnimationPlayer
@onready var flip_audio = $FlipAudio


func _ready():
	flip_audio.stream = flip_sound


func _on_forward_area_body_entered(_body):
	animation_player.play("forward")
	if !Global.mute:
		flip_audio.play()
#		await get_tree().create_timer(0.06).timeout
#		flip_audio.play()


func _on_backward_area_body_entered(_body):
	if !Global.mute:
		flip_audio.play()
	animation_player.play("backward")


func _on_flip_audio_finished():
	Score.event(score_event)
	if animation_player.is_playing():
		flip_audio.play()
