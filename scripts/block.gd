extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 30
const MAX_FALL_SPEED = 350

const SPEED = 300

var motion = Vector2()

var character = null

func _ready():
	self.z_index = 10

func _physics_process(_delta):
	_apply_gravity()
	
	if not is_on_floor():
		_stop_block()
	
	var _velocity = move_and_slide(motion, UP)

func _apply_gravity():
	motion.y += GRAVITY
	
	if (motion.y > MAX_FALL_SPEED):
		motion.y = MAX_FALL_SPEED

func _move_block(direction):
	motion.x = SPEED * direction

func _stop_block():
	motion.x = 0

func _on_body_entered(body):
	if body.is_in_group("character"):
		character = body

func _on_body_exited(body):
	if body.is_in_group("character"):
		_stop_block()
		character = null
