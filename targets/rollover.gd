extends Area3D


@export var sound: AudioStreamWAV
@onready var rollover_audio = $Rollover_Audio
@onready var light = $Light


func _ready():
	rollover_audio.stream = sound


func _on_body_entered(_body):
		Print.from(PrintScope.GLOBAL, "Rollover %s hit" % [name], Print.VERBOSE)
		light.toggle()
