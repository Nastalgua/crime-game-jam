extends RichTextLabel

onready var char_management = get_parent().get_parent().get_parent().get_node("Characters")
export (bool) var debug_mode = false

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if debug_mode and char_management != null:
		var debug_text = ""
		
		var current_character = char_management.get_child(char_management.current_character)
		
		debug_text += "Current character: " + current_character.name + "\n"
		debug_text += "Current character state: " + str(current_character.STATES.keys()[current_character.state]) + "\n"
		debug_text += "Character state: \n"
		
		for character in char_management.get_children():
			debug_text += "[" + character.name + ": " + str(character.active) + "] \n"
		
		set_text(debug_text)
		
		if Input.is_action_just_pressed("ui_reset"):
			var _stupid = get_tree().reload_current_scene()
