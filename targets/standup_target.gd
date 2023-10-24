extends StaticBody3D

@export var hit := false
@export var hit_sound: AudioStreamWAV
@export var hit_while_down_sound: AudioStreamWAV
@export var score_event := "Standup Target Hit"
@onready var animation_player := $AnimationPlayer
@onready var target_hit_audio := $Target_Hit
@onready var target_hit_again := $Target_Hit_Again
@onready var light := $Light
@onready var twinkle_timer = $TwinkleTimer

signal target_hit
signal test_complete


func _ready():
	target_hit_audio.stream = hit_sound
	target_hit_again.stream = hit_while_down_sound


func on_hit():
		animation_player.play("hit")
		if !Global.mute:
			target_hit_audio.play()
		hit = true


func tick(tick_count: int):
	if tick_count % 3 == 0:
		light.activate()
	else:
		light.deactivate()


func test():
	on_hit()
	await get_tree().create_timer(0.1).timeout
	emit_signal("test_complete")
	await animation_player.animation_finished
	reset()


func reset():
	animation_player.play("reset")
	hit = false
	twinkle_timer.stop()
	light.deactivate()


func twinkle():
	twinkle_timer.start()
	await get_tree().create_timer(3).timeout
	twinkle_timer.stop()
	if hit:
		light.activate()


func _on_area_3d_body_entered(_body):
	Score.event(score_event)
	emit_signal("target_hit")
	if !hit:
		on_hit()
	elif !Global.mute:
		target_hit_again.play()
	twinkle()


func _on_twinkle_timer_timeout():
	light.toggle()
