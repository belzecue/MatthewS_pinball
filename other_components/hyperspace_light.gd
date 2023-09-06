extends Light

signal target_hit

@export var rollover_sound: AudioStreamWAV
@export var delay_time := 1.0
@onready var rollover_audio = $Detection/Rollover_Audio


func _ready():
	rollover_audio.stream = rollover_sound


func _on_detection_body_entered(body):
	if !Global.mute and !_is_lit:
		rollover_audio.play()
	activate()
	emit_signal("target_hit")


func _on_detection_body_exited(body):
	await get_tree().create_timer(delay_time).timeout
	deactivate()
