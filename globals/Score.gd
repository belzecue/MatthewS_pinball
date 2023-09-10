extends Node

@export var score_events := {
		"Points_Added" : 1000
	}

@export var _score := 0
@export var _high_score := 0
@export var _ball := 1


func event(e_name: String):
	assert(score_events.has(e_name))
	Print.from(0, e_name + " %s points!" % score_events[e_name], Print.VERBOSE)
	add(score_events[e_name])


func add(val: int):
	_score += val


func add_ball():
	_ball += 1


func is_game_over():
	return (_ball > 3)


func get_score():
	return _score


func get_high_score():
	return _high_score


func get_ball():
	return _ball


func reset():
	if _score > _high_score:
		_high_score = _score
	_score = 0
	_ball = 1
