extends Node

var current_character = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_child(0).active = true

func _input(event):
	if event.is_action_pressed("ui_switch_character_left"):
		if current_character == 0:
			current_character = self.get_children().size() - 1
		else:
			current_character -= 1
		
		for node in self.get_children():
			node.active = false
		
		var character = get_child(current_character)
		character.active = true
	
	if event.is_action_pressed("ui_switch_character_right"):
		if current_character == self.get_children().size() - 1:
			current_character = 0
		else:
			current_character += 1
		
		for node in self.get_children():
			node.active = false
		
		var character = get_child(current_character)
		character.active = true
