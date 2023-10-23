extends AnimatableBody3D

@export var fire: AudioStreamWAV
@export var force := 10.0
@export var score_event := "Rebound"
@onready var animation_player = $AnimationPlayer
@onready var fire_sound = $FireSound
@onready var shot_origin = $ShotOrigin
signal test_complete


func _ready():
	fire_sound.stream = fire


func test():
	hit()
	await animation_player.animation_finished
	emit_signal("test_complete")


func hit():
	if !Global.mute:
		fire_sound.play()
	animation_player.play("hit")


func _on_area_3d_body_entered(body: RigidBody3D):
	if !animation_player.is_playing():
		Score.event(score_event)
		var direction = (body.global_position - shot_origin.global_position)
		direction.y = 0
		direction = direction.normalized()
		Print.from(PrintScope.GLOBAL, "Slingshot %s hit. Applying Force %s" % [name, direction * force], Print.VERBOSE)
		body.apply_central_impulse(direction * force)
