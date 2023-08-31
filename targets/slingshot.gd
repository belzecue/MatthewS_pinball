extends AnimatableBody3D

@onready var animation_player = $AnimationPlayer


func _on_area_3d_body_entered(_body):
	if !animation_player.is_playing():
		Print.from(PrintScope.GLOBAL, "Slingshot %s hit" % [name], Print.VERBOSE)
		animation_player.play("hit")
