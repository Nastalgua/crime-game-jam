extends KinematicBody2D

onready var sprite = get_node("AnimatedSprite")

onready var active = false

const COLLISION_LAYERS = {
	"current_character" : 0,
	"disable_characters" : 1,
	"interactables"     : 2,
	"environment"       : 3
}

const UP = Vector2(0, -1)
const GRAVITY = 30
const MAX_FALL_SPEED = 350
const JUMP_HEIGHT = -520

var acceleration = 100
var max_speed = 420

var motion = Vector2()
var has_friction = false
var direction = 0

var prev_block = null

const STATES = {
	IDLE = 0,
	RUN = 1,
	JUMP = 2,
	PUSH = 3
}

var state = STATES.IDLE

func _physics_process(_delta):
	_apply_gravity()
	
	if active:
		self.z_index = 5
		self.modulate.a = 1
		
		_controller()
	else:
		self.z_index = 4
		self.modulate.a = 0.5
		
		state = STATES.IDLE
		
		motion.x = lerp(motion.x, 0, 0.2)
	
	var _velocity = move_and_slide(motion, UP)

func _process(_delta):
	_state_machine()
	
	# Collisions
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if collision.collider.is_in_group("moveable"):
			# Check if block is below player
			if collision.normal == Vector2(0, -1):
				return
			
			prev_block = collision.collider
			
			if collision.collider.has_method("_move_block"):
				collision.collider._move_block(direction)
				state = STATES.PUSH
		else:
			_stop_block()
		
		# Check for environment above player
		if collision.normal == Vector2(0, 1):
			motion.y = 0

func _apply_gravity():
	motion.y += GRAVITY
	
	if (motion.y > MAX_FALL_SPEED):
		motion.y = MAX_FALL_SPEED

func _controller():
	# Horiontal movement
	direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	if direction != 0:
		if state != STATES.PUSH and is_on_floor():
			state = STATES.RUN
		
		sprite.flip_h = motion.x < 0
		
		motion.x = lerp(0, (direction * min( abs(motion.x) + acceleration, max_speed)), 0.97)
	else:
		if is_on_floor():
			state = STATES.IDLE
		
		_stop_block()
		
		motion.x = lerp(motion.x, 0, 0.2)
		has_friction = true

	# Vertical movement
	if is_on_floor():
		if Input.is_action_just_pressed("ui_jump"):
			state = STATES.JUMP
			motion.y = JUMP_HEIGHT
		
		if has_friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		_stop_block()
		
		if has_friction: 
			motion.x = lerp(motion.x, 0, 0.05)

func _state_machine():
	match state:
		STATES.IDLE:
			sprite.play("idle")
		STATES.RUN:
			sprite.play("run")
			pass
		STATES.JUMP:
			sprite.play("jump")
			pass
		STATES.PUSH:
			sprite.play("push")
			pass

func _stop_block():
	if not prev_block == null and prev_block.has_method("_stop_block"):
		prev_block._stop_block()
		prev_block = null
