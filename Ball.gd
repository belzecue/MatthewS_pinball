extends RigidBody3D

var should_reposition := false
var target_position := Vector3.ZERO


func move(pos: Vector3):
	should_reposition = true
	target_position = pos

func _integrate_forces(state: PhysicsDirectBodyState3D):
	if should_reposition:
		state.transform.origin = target_position
		state.linear_velocity = Vector3.ZERO
		should_reposition = false
