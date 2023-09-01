extends Node3D

@export var flip_sound: AudioStreamWAV
@onready var animation_player = $AnimationPlayer
@onready var flip_audio = $FlipAudio


func _ready():
	flip_audio.stream = flip_sound


func _on_forward_area_body_entered(body):
	if !Global.mute:
		flip_audio.play()
	animation_player.play("forward")


func _on_backward_area_body_entered(body):
	if !Global.mute:
		flip_audio.play()
	animation_player.play("backward")


func _on_flip_audio_finished():
	if animation_player.is_playing():
		flip_audio.play()
