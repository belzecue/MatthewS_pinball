extends AnimatableBody3D

@onready var animation_player = $AnimationPlayer


func _on_area_3d_body_entered(body):
	if !animation_player.is_playing():
		animation_player.play("hit")
