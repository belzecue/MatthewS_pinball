extends Node3D

@export var reset_sound: AudioStreamWAV
@onready var targets = $Targets.get_children()  # This gets all the child nodes under Targets.
@onready var light = $Light
@onready var reset_audio = $Reset_Audio

var total_targets = 0
var hit_targets = 0

func _ready():
	reset_audio.stream = reset_sound
	total_targets = targets.size()
	for target in targets:
		target.connect("target_hit", _on_target_hit)  # Connect the signal from each target to the bank.


func _on_target_hit():
	hit_targets += 1
	if hit_targets >= total_targets:
		await get_tree().create_timer(0.2).timeout
		reset_all_targets()
		hit_targets = 0
		light.toggle()


func reset_all_targets():
	if !Global.mute:
		reset_audio.play()
	for target in targets:
		target.reset()
