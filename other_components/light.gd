extends Node3D
class_name Light

@onready var unlit = $Unlit
@onready var lit = $Lit
var _is_lit := false


func _ready():
	self.add_to_group("ball_reset")


func toggle():
	if !_is_lit:
		activate()
	else:
		deactivate()


func reset():
	deactivate()


func activate():
	_is_lit = true
	lit.visible = true
	unlit.visible = false


func deactivate():
	_is_lit = false
	unlit.visible = true
	lit.visible = false
