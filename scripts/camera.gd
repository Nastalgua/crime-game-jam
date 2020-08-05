extends Camera2D

onready var character_target = null
#onready var characters = get_parent().get_node("Characters")

func _ready():
	#self.position = Vector2(get_viewport_rect().size.x * 2, get_viewport_rect().size.y * 2)
	#if (characters.get_children().size() > 0):
	#	var current_character = characters.current_character
	#	character_target = characters.get_child(current_character)
	#	
	#self.position = character_target.position
	pass

func _process(_delta):
	#if (characters.get_children().size() > 0):
	#	var current_character = characters.current_character
	#	character_target = characters.get_child(current_character)
	
	#self.position = lerp(self.position, character_target.position, 0.2)
	
	#var x_to = character_target.position.x
	#var y_to = character_target.position.y
	
	#self.position.x += (x_to - self.position.x) / 25
	#self.position.y += (y_to - self.position.y) / 25
	pass
