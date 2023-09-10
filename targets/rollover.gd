extends Area3D


@export var sound: AudioStreamWAV
@export var score_event := "Rollover Target Activated"
@onready var rollover_audio := $Rollover_Audio
@onready var light := $Light

signal rollover_hit

var active := false


func _ready():
	rollover_audio.stream = sound


func reset():
	active = false
	light.deactivate()


func activate():
	active = true
	light.activate()


func tick(_tick):
	if randi() % 3 == 0:
		light.activate()
	else:
		light.deactivate()


func _on_body_entered(_body):
	Score.event(score_event)
	if !Global.mute:
		rollover_audio.play()
	if active:
		reset()
	else:
		activate()
	emit_signal("rollover_hit")
