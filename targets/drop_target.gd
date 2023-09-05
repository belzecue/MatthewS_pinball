extends StaticBody3D

@export var hit := false

@onready var animation_player = $AnimationPlayer
@onready var hit_1 = $Hit1
@onready var hit_2 = $Hit2
@onready var light = $Light

signal target_hit


func on_hit():
		animation_player.play("hit")
		Print.from(PrintScope.GLOBAL, "Target %s hit" % [name], Print.VERBOSE)
		if randi() % 1 == 0:
			hit_1.play()
		else:
			hit_2.play()
		emit_signal("target_hit")
		hit = true
		light.activate()


func reset():
	animation_player.play("reset")
	hit = false
	light.deactivate()


func _on_area_3d_body_entered(_body):
	if !hit:
		on_hit()
