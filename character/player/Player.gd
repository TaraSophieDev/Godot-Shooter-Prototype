extends KinematicBody

export var mouse_sensitivity = 0.3

onready var camera = $Camera
onready var character_mover = $CharacterMover
onready var health_manager = $HealthManager

var dead = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	character_mover.init(self)
	health_manager.init()
	health_manager.connect("dead", self, "kill")
	
func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
		
	if dead:
		return
		
	var move_vector = Vector3()
	if Input.is_action_pressed("move_forwards"):
		move_vector += Vector3.FORWARD
	if Input.is_action_pressed("move_backwards"):
		move_vector += Vector3.BACK
	if Input.is_action_pressed("move_left"):
		move_vector += Vector3.LEFT
	if Input.is_action_pressed("move_right"):
		move_vector += Vector3.RIGHT
	character_mover.set_move_vector(move_vector)
	if Input.is_action_just_pressed("jump"):
		character_mover.jump()

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= mouse_sensitivity * event.relative.x
		camera.rotation_degrees.x -= mouse_sensitivity * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
		
func hurt(damage, dir):
	health_manager.hurt(damage, dir)
	
func heal(amount):
	health_manager.heal(amount)

func kill():
	dead = true
	character_mover.freeze()
