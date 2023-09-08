extends AnimatableBody3D

@export var fire: AudioStreamWAV
@export var force := 10.0
@onready var animation_player = $AnimationPlayer
@onready var fire_sound = $FireSound
@onready var shot_origin = $ShotOrigin


func _ready():
	fire_sound.stream = fire


func _on_area_3d_body_entered(body: RigidBody3D):
	if !animation_player.is_playing():
		if !Global.mute:
			fire_sound.play()
		animation_player.play("hit")
		var direction = (body.global_position - shot_origin.global_position)
		direction.y = 0
		direction = direction.normalized()
		Print.from(PrintScope.GLOBAL, "Slingshot %s hit. Applying Force %s" % [name, direction * force], Print.VERBOSE)
		body.apply_central_impulse(direction * force)
