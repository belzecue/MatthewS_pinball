extends MeshInstance3D
class_name Mirror

@export var material_off: StandardMaterial3D
@export var material_dim: StandardMaterial3D
@export var material_mid: StandardMaterial3D
@export var material_lit: StandardMaterial3D
@export var lightspeed_tick := 0.1
@onready var mirror_levels = $MirrorLevels.get_children()

var current_rotated_pattern = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]


func _ready():
	$Tick.start(lightspeed_tick)
	for i in range(mirror_levels.size()):
		var ring = mirror_levels[i]
		if ring is Node3D:
			ring.initialize(material_off, material_dim, material_mid, material_lit, current_rotated_pattern.duplicate())


func set_pattern(pattern: Array):
	assert(pattern.size() == 24)
	current_rotated_pattern = pattern.duplicate()


func rotate_pattern(direction: int):
	if direction > 0:
		var last_element = current_rotated_pattern[current_rotated_pattern.size() - 1]
		current_rotated_pattern.pop_back()
		current_rotated_pattern.insert(0, last_element)
	else:
		var first_element = current_rotated_pattern.pop_front()
		current_rotated_pattern.append(first_element)


func _on_tick_timeout():
	for i in range(mirror_levels.size() - 1, 0, -1):  # Start from the last and move to the first
		var current_ring = mirror_levels[i]
		var previous_ring = mirror_levels[i - 1]
		
		# Only update if the brightness values are different
		if hash(current_ring.brightness_values) != hash(previous_ring.brightness_values):
			current_ring.set_leds_brightness(previous_ring.brightness_values)
	
	if hash(mirror_levels[0].brightness_values) != hash(current_rotated_pattern):
		mirror_levels[0].set_leds_brightness(current_rotated_pattern.duplicate())  # Set the brightness of the first ring
