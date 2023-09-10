extends Node3D

@export var score_event := "Lanes Filled"
@onready var rollovers := self.get_children()


func _ready():
	# Connect signals
	for rollover in rollovers:
		rollover.connect("rollover_hit", _on_rollover_rollover_hit)


func _input(event):
	# Listen for the left and right keys and adjust the active rollover accordingly
	if event.is_action_pressed("LFlipper"):
		move_active_status(-1)
	elif event.is_action_pressed("RFlipper"):
		move_active_status(1)


func move_active_status(direction):
	var statuses = []
	
	# Store current statuses of rollovers in an array
	for rollover in rollovers:
		statuses.append(rollover.active)
	
	# Update each rollover's status based on its neighbor's status
	for i in range(rollovers.size()):
		var new_status = false
		if direction == -1:
			# Get status from the rollover to the right
			new_status = statuses[(i+1) % rollovers.size()]
		else:
			# Get status from the rollover to the left
			new_status = statuses[(i-1) % rollovers.size()]

		# Update rollover status
		if new_status:
			rollovers[i].activate()
		else:
			rollovers[i].reset()

func _on_rollover_rollover_hit():
	# Check if all rollovers are active
	for rollover in rollovers:
		if not rollover.active:
			return
	
	# If all rollovers are active, deactivate.
	for rollover in rollovers:
		rollover.reset()
