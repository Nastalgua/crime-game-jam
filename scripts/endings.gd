extends Node2D

var ending_text = "Yo"

func _ready():
	get_node("RichTextLabel").text = ending_text
