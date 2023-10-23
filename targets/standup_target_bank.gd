extends Node3D

@onready var targets = get_children()  # This gets all the child nodes under Targets.
@export var score_event := "All Targets Down"
signal test_complete

var total_targets = 0
var hit_targets = 0
var reset_count = 0

func _ready():
	total_targets = targets.size()
	for target in targets:
		target.connect("target_hit", _on_target_hit)  # Connect the signal from each target to the bank.


func _on_target_hit():
	hit_targets += 1
	if hit_targets >= total_targets:
		for target in targets:
			target.twinkle()
		await get_tree().create_timer(3).timeout
		Score.event(score_event)
		reset_all_targets()
		hit_targets = 0


func reset():
	reset_all_targets()


func tick(tick_count):
	for i in range(targets.size()):
		targets[i].tick(tick_count + i)


func test():
	for target in targets:
		target.test()
		await target.test_complete
		
	emit_signal("test_complete")


func reset_all_targets():
	for target in targets:
		target.reset()
