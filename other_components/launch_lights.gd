extends Node3D

@export var skill_shot_sound: AudioStreamWAV
@export var skill_shot_event := "Skill Shot"
@onready var skill_shot_audio = $SkillShot/Detection/Rollover_Audio
@onready var light_1 = $Light1
@onready var light_2 = $Light2
@onready var light_3 = $Light3
@onready var light_4 = $Light4
@onready var light_5 = $Light5
@onready var light_6 = $Light6

var _launching := false


func tick(ticks):
	light_1.tick(ticks)
	light_2.tick(ticks + 1)
	light_3.tick(ticks + 2)
	light_4.tick(ticks + 3)
	light_5.tick(ticks + 4)
	light_6.tick(ticks + 5)


# The ball left the tube. Reset for next time.
func delay_reset():
	_launching = false
	await get_tree().create_timer(1).timeout
	reset()


func reset():
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
		Score.event(skill_shot_event)
		delay_reset()


func _on_exit_body_entered(_body):
	delay_reset()
