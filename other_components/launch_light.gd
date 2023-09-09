extends Light

signal target_hit

@export var rollover_sound: AudioStreamWAV
@export var score_event := "Launch Light"
@onready var rollover_audio = $Detection/Rollover_Audio


func _ready():
	rollover_audio.stream = rollover_sound


func _on_area_3d_body_entered(_body):
	if !Global.mute and !_is_lit:
		rollover_audio.play()
	activate()
	emit_signal("target_hit")
	Score.event(score_event)
