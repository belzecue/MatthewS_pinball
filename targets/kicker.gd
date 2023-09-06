extends Node3D

@export var kick_sound: AudioStreamWAV
@onready var animation_player = $AnimationPlayer
@onready var kick_audio = $KickAudio


func _ready():
	kick_audio.stream = kick_sound


func _on_area_3d_body_entered(_body):
	if !animation_player.is_playing():
		await get_tree().create_timer(1).timeout
		if !Global.mute:
			kick_audio.play()
		animation_player.play("kick_ball")
