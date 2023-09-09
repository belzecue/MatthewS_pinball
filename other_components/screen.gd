extends Node3D

@export_enum("ALL_OFF", "ALL_ON", "EVERY_OTHER", "FOUR_QUADRANTS", "OPPOSITE_SIDES") var current_pattern: int = Mirror.Patterns.ALL_OFF

@onready var infinity_mirror: Mirror = $InfinityMirror


func _ready():
		infinity_mirror.set_pattern(current_pattern)


func _on_update_timer_timeout():
	# TODO: blank via option in mirror script, should pause current pattern rotation.
	if infinity_mirror.current_pattern == Mirror.Patterns.ALL_OFF:
		infinity_mirror.set_pattern(current_pattern)
		
	else:
		infinity_mirror.set_pattern(Mirror.Patterns.ALL_OFF)
