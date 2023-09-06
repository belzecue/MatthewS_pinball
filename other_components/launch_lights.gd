extends Node3D

@export var skill_shot_sound: AudioStreamWAV
@onready var skill_shot_audio = $SkillShot/Detection/Rollover_Audio
@onready var light_1 = $Light1
@onready var light_2 = $Light2
@onready var light_3 = $Light3
@onready var light_4 = $Light4
@onready var light_5 = $Light5
@onready var light_6 = $Light6

var _launching := false


# The ball left the tube. Reset for next time.
func _launch():
	_launching = false
	await get_tree().create_timer(1).timeout
	light_1.deactivate()
	light_2.deactivate()
	light_3.deactivate()
	light_4.deactivate()
	light_5.deactivate()
	light_6.deactivate()


func _ready():
	skill_shot_audio.stream = skill_shot_sound


func _on_light_1_target_hit():
	pass # Replace with function body.


func _on_light_2_target_hit():
	pass # Replace with function body.


func _on_light_3_target_hit():
	pass # Replace with function body.


func _on_light_4_target_hit():
	pass # Replace with function body.


func _on_light_5_target_hit():
	pass # Replace with function body.


func _on_light_6_target_hit():
	_launching = true


func _on_skill_shot_body_entered(_body):
	if _launching:
		skill_shot_audio.play()
		_launch()


func _on_exit_body_entered(_body):
	if _launching:
		_launch()
