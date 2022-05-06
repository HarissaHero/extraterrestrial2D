extends KinematicBody2D

class_name Actor

const FLOOR_NORMAL := Vector2.UP

export var gravity := 3000.0
export var speed := Vector2(300.0, 1500.0)

var _velocity := Vector2.ZERO


func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var out = linear_velocity
	out.x = direction.x * speed.x
	out.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		out.y = direction.y * speed.y
	if is_jump_interrupted:
		out.y = 0.0
	return out
