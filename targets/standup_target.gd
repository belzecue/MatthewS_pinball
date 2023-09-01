extends StaticBody3D

@onready var animation_player = $AnimationPlayer
@export var hit := false
@onready var target_hit = $Target_Hit
@onready var target_hit_again = $Target_Hit_Again


func on_hit():
		animation_player.play("hit")
		target_hit.play()
		Print.from(PrintScope.GLOBAL, "Target %s hit" % [name], Print.VERBOSE)
		hit = true


func reset():
	animation_player.play("reset")
	hit = false


func _on_area_3d_body_entered(_body):
	if !hit:
		on_hit()
	else :
		target_hit_again.play()
