extends StaticBody3D

@onready var animation_player = $AnimationPlayer
@export var hit := false
@onready var hit_1 = $Hit1
@onready var hit_2 = $Hit2


func on_hit():
		animation_player.play("hit")
		Print.from(PrintScope.GLOBAL, "Target %s hit" % [name], Print.VERBOSE)
		if randi() % 1 == 0:
			hit_1.play()
		else:
			hit_2.play()
		hit = true


func reset():
	animation_player.play("reset")
	hit = false


func _on_area_3d_body_entered(_body):
	if !hit:
		on_hit()
