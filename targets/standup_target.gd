extends StaticBody3D

@export var hit := false
@export var hit_sound: AudioStreamWAV
@export var hit_while_down_sound: AudioStreamWAV
@onready var animation_player := $AnimationPlayer
@onready var target_hit := $Target_Hit
@onready var target_hit_again := $Target_Hit_Again
@onready var light := $Light


func _ready():
	target_hit.stream = hit_sound
	target_hit_again.stream = hit_while_down_sound


func on_hit():
		animation_player.play("hit")
		target_hit.play()
		Print.from(PrintScope.GLOBAL, "Target %s hit" % [name], Print.VERBOSE)
		hit = true
		light.activate()


func reset():
	animation_player.play("reset")
	hit = false
	light.deactivate()


func _on_area_3d_body_entered(_body):
	if !hit:
		on_hit()
	else :
		target_hit_again.play()
