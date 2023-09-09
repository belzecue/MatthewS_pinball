extends MeshInstance3D
class_name Mirror

@export var material_off: StandardMaterial3D
@export var material_dim: StandardMaterial3D
@export var material_mid: StandardMaterial3D
@export var material_lit: StandardMaterial3D
@export var lag_frames := 3
@onready var timer = $"../RotateTimer"
@onready var mirror_levels = self.get_children()
var frame_count := 0

enum Patterns {
	ALL_OFF,
	ALL_ON,
	EVERY_OTHER,
	FOUR_QUADRANTS,
	OPPOSITE_SIDES
}

const PATTERN_DATA = {
	Patterns.ALL_OFF:        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	Patterns.ALL_ON:         [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3],
	Patterns.EVERY_OTHER:    [0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3],
	Patterns.FOUR_QUADRANTS: [3, 2, 1, 0, 1, 2, 3, 2, 1, 0, 1, 2, 3, 2, 1, 0, 1, 2, 3, 2, 1, 0, 1, 2],
	Patterns.OPPOSITE_SIDES: [3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2]
}

var pattern_settings = {
	Patterns.ALL_OFF: {"interval": 0.3, "rotation": 0},
	Patterns.ALL_ON: {"interval": 0.3, "rotation": 1},
	Patterns.EVERY_OTHER: {"interval": 0.3, "rotation": 1},
	Patterns.FOUR_QUADRANTS: {"interval": 0.1, "rotation": 1},
	Patterns.OPPOSITE_SIDES: {"interval": 0.2, "rotation": 1}
}

@export_enum("ALL_OFF", "ALL_ON", "EVERY_OTHER", "FOUR_QUADRANTS", "OPPOSITE_SIDES") var current_pattern: int = Patterns.ALL_OFF
var current_rotated_pattern = []


func _ready():
	set_pattern(current_pattern)
	
	for i in range(mirror_levels.size()):
		var ring = mirror_levels[i]
		if ring is Node3D:
			ring.initialize(material_off, material_dim, material_mid, material_lit, current_rotated_pattern.duplicate())


func _process(_delta):
	frame_count += 1
	if frame_count > lag_frames:
		frame_count = 0
	else:
		return
	
	for i in range(mirror_levels.size() - 1, 0, -1):  # Start from the last and move to the first
		var current_ring = mirror_levels[i]
		var previous_ring = mirror_levels[i - 1]
		
		# Only update if the brightness values are different
		if hash(current_ring.brightness_values) != hash(previous_ring.brightness_values):
			current_ring.set_leds_brightness(previous_ring.brightness_values)
	
	if hash(mirror_levels[0].brightness_values) != hash(current_rotated_pattern):
		mirror_levels[0].set_leds_brightness(current_rotated_pattern.duplicate())  # Set the brightness of the first ring


func set_pattern(pattern):
	current_pattern = pattern
	current_rotated_pattern = PATTERN_DATA[pattern].duplicate()  # initialize the current rotated pattern
	timer.start(pattern_settings[pattern]["interval"])


func rotate_pattern(direction):
	if direction > 0:
		var last_element = current_rotated_pattern[current_rotated_pattern.size() - 1]
		current_rotated_pattern.pop_back()
		current_rotated_pattern.insert(0, last_element)
	else:
		var first_element = current_rotated_pattern.pop_front()
		current_rotated_pattern.append(first_element)


func _on_timer_timeout():
	rotate_pattern(pattern_settings[current_pattern]["rotation"])
