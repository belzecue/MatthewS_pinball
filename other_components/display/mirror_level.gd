extends Node3D

# Materials will be set from the parent and will not be @export-ed
var material_off: StandardMaterial3D
var material_dim: StandardMaterial3D
var material_mid: StandardMaterial3D
var material_lit: StandardMaterial3D

@onready var leds = $LEDs.get_children()

# Brightness values will be set from the parent
var brightness_values := []


func initialize(off: StandardMaterial3D, dim: StandardMaterial3D, mid: StandardMaterial3D, lit: StandardMaterial3D, brightness: Array) -> void:
	material_off = off
	material_dim = dim
	material_mid = mid
	material_lit = lit
	# Once initialized, you can also set the brightness of LEDs immediately if needed
	set_leds_brightness(brightness)


func set_leds_brightness(values := brightness_values) -> void:
	# Ensure we have the correct number of brightness values for our LEDs
	assert(leds.size() == values.size())
	brightness_values = values
	for i in range(leds.size()):
		set_led_brightness(leds[i], brightness_values[i])


func set_led_brightness(led: MeshInstance3D, brightness: int) -> void:
	if brightness < 0 or brightness > 3:
		Print.from(PrintScope.GLOBAL, "Invalid brightness value: %s" % [brightness], Print.ERROR)
		return

	match brightness:
		0:
			led.material_override = material_off
		1:
			led.material_override = material_dim
		2:
			led.material_override = material_mid
		3:
			led.material_override = material_lit
