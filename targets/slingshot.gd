extends AnimatableBody3D

@export var fire: AudioStreamWAV
@onready var animation_player = $AnimationPlayer
@onready var fire_sound = $FireSound


func _ready():
	fire_sound.stream = fire


func _on_area_3d_body_entered(_body):
	if !animation_player.is_playing():
		Print.from(PrintScope.GLOBAL, "Slingshot %s hit" % [name], Print.VERBOSE)
		if !Global.mute:
			fire_sound.play()
		animation_player.play("hit")
