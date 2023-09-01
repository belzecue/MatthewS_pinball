extends Node3D

@onready var targets = $Targets.get_children()  # This gets all the child nodes under Targets.

var total_targets = 0
var hit_targets = 0

func _ready():
	total_targets = targets.size()
	for target in targets:
		target.connect("target_hit", _on_target_hit)  # Connect the signal from each target to the bank.


func _on_target_hit():
	hit_targets += 1
	if hit_targets >= total_targets:
		reset_all_targets()
		hit_targets = 0


func reset_all_targets():
	for target in targets:
		target.reset()
