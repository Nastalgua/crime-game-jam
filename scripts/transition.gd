extends Node2D

export (float) var fade_time = 0.5

func _ready():
	pass

func _process(_delta):
	#if Input.is_action_just_pressed("ui_accept"):
	#	print("change")
	#	var rect = get_node("ColorRect")
	#	
	#	# Fade in
	#	get_node("Tween").interpolate_property(rect, "modulate:a", rect.modulate.a, 1, fade_time, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	#	get_node("Tween").start()
		
	#	# Fade out
	#	get_node("Tween").interpolate_property(rect, "modulate:a", rect.modulate.a, 0, fade_time, Tween.TRANS_CUBIC, Tween.EASE_IN)
	#	get_node("Tween").start()
	pass

