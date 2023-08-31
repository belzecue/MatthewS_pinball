extends StaticBody3D

@onready var animation_player = $AnimationPlayer
@export var hit := false


func _on_area_3d_body_entered(_body):
	if !hit:
		animation_player.play("hit")
		Print.from(PrintScope.GLOBAL, "Target %s hit" % [name], Print.VERBOSE)
		hit = true
