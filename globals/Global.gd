extends Node3D

enum Mode {
	BOOT,
	IDLE,
	DEMO,
	PLAYING,
	GAMEOVER,
}

@export var debug_mode := false
@export var mute := false
@export var skip_intro := false
@export var tilt := false
@export var game_mode := Mode.BOOT
@export var screen_text_disabled := false
@export var screen_effects_disabled := false
