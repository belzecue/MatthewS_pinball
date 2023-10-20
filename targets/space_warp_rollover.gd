extends Light

signal target_hit

@export var rollover_sound: AudioStreamWAV
@export var delay_time := 0.1
@export var score_event := "Space Warp Rollover"
@onready var rollover_audio = $Detection/Rollover_Audio


func _ready():
	rollover_audio.stream = rollover_sound
	add_to_group("ball_reset")
	add_to_group("demo")
	add_to_group("boot")


func tick(ticks):
	if ticks % 1 == 0:
		activate()
	else:
		deactivate()


func _on_detection_body_entered(_body):
	if !Global.mute and !_is_lit:
		rollover_audio.play()
	activate()
	emit_signal("target_hit")
	Score.event(score_event)


func _on_detection_body_exited(_body):
	await get_tree().create_timer(delay_time).timeout
	deactivate()
