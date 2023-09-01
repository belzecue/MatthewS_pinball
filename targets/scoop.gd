extends AnimatableBody3D

@export var enter_sound : AudioStreamWAV
@export var exit_sound : AudioStreamWAV
@onready var animation_player := $AnimationPlayer
@onready var enter_audio := $Enter_Audio
@onready var exit_audio := $Exit_Audio


func _ready():
	enter_audio.stream = enter_sound
	exit_audio.stream = exit_sound


func _on_area_3d_body_entered(_body):
	if !animation_player.is_playing() and !enter_audio.playing:
		Print.from(PrintScope.GLOBAL, "%s Scoop activated" % [name], Print.VERBOSE)
		enter_audio.play()


func _on_enter_audio_finished():
	animation_player.play("hit")
	exit_audio.play()
