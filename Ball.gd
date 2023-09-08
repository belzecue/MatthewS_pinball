extends RigidBody3D

var should_reposition := false
var target_position := Vector3.ZERO
var target_velocity := Vector3.ZERO


func move(pos: Vector3):
	should_reposition = true
	target_position = pos
	target_velocity = Vector3.ZERO


func throw(pos: Vector3, vel: Vector3):
	should_reposition = true
	target_position = pos
	target_velocity = vel


func _integrate_forces(state: PhysicsDirectBodyState3D):
	if should_reposition:
		state.transform.origin = target_position
		state.linear_velocity = target_velocity
		state.angular_velocity = Vector3.ZERO
		should_reposition = false
