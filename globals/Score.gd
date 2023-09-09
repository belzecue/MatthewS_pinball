extends Node

@export var score_events := {
		"Points_Added" : 1000
	}

@export var _score := 0
@export var _high_score := 0
@export var _ball := 1


func event(_event: String):
	add(score_events[_event])


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
