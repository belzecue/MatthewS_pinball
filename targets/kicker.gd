extends Node3D

@export var force := 10.0
@export var delay_time := 1.0
@export var kick_sound: AudioStreamWAV
@onready var animation_player = $AnimationPlayer
@onready var kick_audio = $KickAudio
@onready var throw = $Throw


func _ready():
	kick_audio.stream = kick_sound


func reset():
	animation_player.play_backwards("kick_ball")


func _on_area_3d_body_entered(body):
	if !animation_player.is_playing():
		await get_tree().create_timer(delay_time).timeout
		if !Global.mute:
			kick_audio.play()
		animation_player.play("kick_ball")
		var direction = (-throw.global_transform.basis.y * force)
		Print.from(PrintScope.GLOBAL, "Kicker %s hit. Applying Force %s" % [name, direction], Print.VERBOSE)
		body.throw(throw.global_position, direction)
