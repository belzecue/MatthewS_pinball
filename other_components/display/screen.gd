extends Node3D
class_name Screen

class Pattern:
	var name: String
	var direction: int
	var rotate_time: float
	var play_time: float
	
	func _init(my_name := "On", my_direction := 0, my_rotate_time := 0.5, my_play_time := 5.0):
		name = my_name
		direction = my_direction
		rotate_time = my_rotate_time
		play_time = my_play_time

const pattern_data := {
	On =           [[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3]],
	Off =          [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
	Every_Other =  [[0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3]],
	Quads_Center = [[3, 2, 1, 0, 1, 2, 3, 2, 1, 0, 1, 2, 3, 2, 1, 0, 1, 2, 3, 2, 1, 0, 1, 2]],
	Quads_CW =     [[3, 0, 0, 0, 1, 2, 3, 0, 0, 0, 1, 2, 3, 0, 0, 0, 1, 2, 3, 0, 0, 0, 1, 2]],
	Quads_CCW =    [[3, 2, 1, 0, 0, 0, 3, 2, 1, 0, 0, 0, 3, 2, 1, 0, 0, 0, 3, 2, 1, 0, 0, 0]],
	Twos_Center =  [[3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2]],
	Twos_CW =      [[3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2]],
	Twos_CCW =     [[3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
	Random =       [[0, 0, 0, 3, 3, 2, 2, 1, 0, 1, 1, 3, 3, 0, 0, 2, 1, 0, 1, 1, 1, 0, 2, 3],
					[2, 1, 3, 0, 1, 0, 1, 2, 1, 3, 1, 2, 3, 0, 1, 0, 2, 1, 0, 2, 1, 1, 2, 0],
					[2, 3, 2, 2, 1, 2, 1, 3, 3, 0, 2, 0, 1, 3, 2, 2, 2, 3, 1, 2, 3, 1, 0, 1],
					[0, 2, 3, 1, 2, 2, 1, 0, 1, 0, 3, 1, 1, 1, 0, 0, 0, 2, 2, 1, 1, 0, 2, 0],
					[3, 3, 2, 1, 1, 1, 2, 3, 2, 1, 0, 1, 3, 1, 2, 0, 1, 0, 0, 3, 0, 2, 0, 1]],
	Bounce =       [[3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2],
					[2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3],
					[1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2],
					[0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1],
					[0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 0],
					[0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 0, 0],
					[0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0],
					[0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0],
					[0, 0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0],
					[0, 0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0, 0],
					[0, 0, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 0],
					[0, 3, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3]]
}

enum TEXT_TYPE {
	OFF,
	START,
	SELFTEST,
	SERVE,
	SCORE,
	HIGH_SCORE,
	GAMEOVER,
	DEMO
}

var mirror_patterns := {
	Boot = [Pattern.new("Random", 0, 0.1, 0)],
	Flash = [Pattern.new("On", 0, 0, 0.1), Pattern.new("Off", 0, 0, 0.1)],
	Vortex = [Pattern.new("Quads_CW", 1, 0.05, 1), Pattern.new("Quads_CCW", -1, 0.05, 1)],
	Spin = [Pattern.new("Quads_Center", 1, 0.2, 0)],
	Demo = [Pattern.new("Quads_Center", 1, 0.2, 3), Pattern.new("On", 0, 0, 0.1), Pattern.new("Off", 0, 0, 0.1), \
		Pattern.new("On", 0, 0, 0.1), Pattern.new("Off", 0, 0, 0.1), Pattern.new("Every_Other", 1, 0.2, 3), \
		Pattern.new("Twos_Center", 1, 0.1, 3), Pattern.new("Twos_Center", -1, 0.1, 3), Pattern.new("Random", 0, 0.1, 3)],
	Epic = [Pattern.new("Twos_CW", 1, 0.05, 1.5), Pattern.new("Twos_CCW", -1, 0.05, 1.5), Pattern.new("Bounce", 0, 0.05, 1.2),
		Pattern.new("Quads_CW", 1, 0.1, 1.5), Pattern.new("Quads_CCW", -1, 0.1, 1.5), Pattern.new("Random", 0, 0.1, 1.5)]
}

@onready var infinity_mirror: Mirror = $InfinityMirror
@onready var text_1 := $SubViewport/Display/VBoxContainer/Text1
@onready var text_2 := $SubViewport/Display/VBoxContainer/Text2
@onready var text_3 := $SubViewport/Display/VBoxContainer/Text3
@onready var rotate_pattern_timer := $RotatePatternTimer
@onready var next_pattern_timer := $NextPatternTimer

@export var pattern: String
var pattern_index := 0
var animation_index := 0
var current_pattern: Pattern
var scroll_text := [false, false, false]

@export var text_mode:= TEXT_TYPE.OFF:
	set(type):
		if Global.screen_text_disabled:
			type = TEXT_TYPE.OFF
		text_mode = type
		match type:
			TEXT_TYPE.OFF:
				scroll_text = [false, false, false]
				text_1.text = ""
				text_2.text = ""
				text_3.text = ""
			TEXT_TYPE.START:
				scroll_text = [false, true, false]
				text_1.text = "3D"
				text_2.text = "  Space Pinball  "
				text_3.text = "initializing"
			TEXT_TYPE.SELFTEST:
				scroll_text = [false, true, false]
				text_1.text = "3D"
				text_2.text = "  Space Pinball  "
				text_3.text = "self_test"
			TEXT_TYPE.SERVE:
				text_3.text = "Serving"
			TEXT_TYPE.SCORE:
				scroll_text = [false, false, false]
				text_1.text = "Score:"
				text_2.text = "%7d" % Score.get_score()
				text_3.text = "Ball " + str(Score.get_ball())
			TEXT_TYPE.HIGH_SCORE:
				scroll_text = [true, false, false]
				text_1.text = "New High Score!"
				text_2.text = "%7d" % Score.get_score()
				text_3.text = "Ball " + str(Score.get_ball())
			TEXT_TYPE.GAMEOVER:
				scroll_text = [false, false, false]
				text_1.text = "Game Over"
				text_2.text = "%7d" % Score.get_score()
				text_3.text = "Your Score"
			TEXT_TYPE.DEMO:
				scroll_text = [true, true, false]
				text_1.text = "  3D Space Pinball  "
				text_2.text = "  High Score: %d  " % Score.get_high_score()
				text_3.text = "Space to\nPlay"

func _ready():
	text_mode = TEXT_TYPE.OFF
	set_pattern("Boot")


func _process(_delta):
	match text_mode:
		TEXT_TYPE.SCORE, TEXT_TYPE.HIGH_SCORE:
			text_2.text = "%7d" % Score.get_score()
			text_3.text = "Ball " + str(Score.get_ball())
		_:
			pass


func set_pattern(pattern_name: String):
	if Global.screen_effects_disabled:
		return
	assert(mirror_patterns.has(pattern_name))
	pattern = pattern_name
	pattern_index = 0
	animation_index = 0
	_update_pattern()


func _update_pattern():
	current_pattern = mirror_patterns[pattern][pattern_index]
	infinity_mirror.set_pattern(pattern_data[current_pattern.name][animation_index])
	
	if current_pattern.rotate_time > 0:
		rotate_pattern_timer.start(current_pattern.rotate_time)
	else:
		rotate_pattern_timer.stop()
	if current_pattern.play_time > 0:
		next_pattern_timer.start(current_pattern.play_time)
	else:
		next_pattern_timer.stop()


func _on_rotate_pattern_timer_timeout():
	if current_pattern.direction == 0:
		animation_index = (animation_index + 1) % (pattern_data[current_pattern.name].size())
		infinity_mirror.set_pattern(pattern_data[current_pattern.name][animation_index])
	else:
		infinity_mirror.rotate_pattern(current_pattern.direction)


func _on_next_pattern_timer_timeout():
	pattern_index = (pattern_index + 1) % (mirror_patterns[pattern].size())
	_update_pattern()


func _on_marquee_timer_timeout():
	var text: String
	if scroll_text[0]:
		text = text_1.text
		text_1.text = text.right(-1) + text.left(1)

	if scroll_text[1]:
		text = text_2.text
		text_2.text = text.right(-1) + text.left(1)
	
	if scroll_text[2]:
		text = text_3.text
		text_3.text = text.right(-1) + text.left(1)
