extends Spatial

var body_to_move : KinematicBody = null

export var move_acceleration = 4
export var max_speed = 25
var drag = 0.0
export var jump_force = 30
export var gravity = 60

var pressed_jump = false
var move_vector : Vector3
var velocity : Vector3
var snap_vec : Vector3
export var ignore_rotation = false
