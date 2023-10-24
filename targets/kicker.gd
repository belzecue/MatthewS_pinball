extends Node3D

@export var force := 10.0
@export var delay_time := 1.0
@export var kick_sound: AudioStreamWAV
@export var score_event := "Kicker Hit"
@onready var animation_player = $AnimationPlayer
@onready var kick_audio = $KickAudio
@onready var throw = $Throw
signal test_complete
var set := false

func _ready():
	kick_audio.stream = kick_sound


func reset():
	if set:
		animation_player.play("reset")
	set = false


func test():
	if !Global.mute:
		kick_audio.play()
	animation_player.play("kick_ball")
	await get_tree().create_timer(0.2).timeout
	emit_signal("test_complete")
	await animation_player.animation_finished
	animation_player.play("reset")


func _on_area_3d_body_entered(body):
	if !set:
		set = true
		await get_tree().create_timer(delay_time).timeout
		Score.event(score_event)
		if !Global.mute:
			kick_audio.play()
		animation_player.play("kick_ball")
		var direction = (-throw.global_transform.basis.y * force)
		Print.from(PrintScope.GLOBAL, "Kicker %s hit. Applying Force %s" % [name, direction], Print.VERBOSE)
		body.throw(throw.global_position, direction)
