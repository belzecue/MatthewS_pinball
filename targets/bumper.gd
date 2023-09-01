extends AnimatableBody3D

@export var sound: AudioStreamWAV
@onready var animation_player = $AnimationPlayer
@onready var pop_player = $PopPlayer


func _ready():
	pop_player.stream = sound


func _on_area_3d_body_entered(_body):
	if !animation_player.is_playing():
		if !Global.mute:
			pop_player.play()
		Print.from(PrintScope.GLOBAL, "Bumper %s hit" % [name], Print.VERBOSE)
		animation_player.play("hit")
