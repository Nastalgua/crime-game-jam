extends Node2D

onready var text = get_node("Label")
onready var game = get_node("/root/Game")
var allow_interaction = false

export (int) var level = 1
export (bool) var is_level = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	if allow_interaction and Input.is_action_just_pressed("ui_interact"):
		print ("Interacting...")
		# game.transition_to_level(level)
		# game.to_base()
		if is_level:
			game.to_base()
		else:
			game.transition_to_level(level)
			
			

func _on_character_entered(body):
	if not body is KinematicBody2D:
		return
	
	allow_interaction = true
	text.modulate.a = 1

func _on_character_exited(_body):
	allow_interaction = false
	text.modulate.a = 0

