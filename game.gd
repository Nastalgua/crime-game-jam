extends Node2D

const LVL_PATH = "res://scenes/levels/Level%d.tscn"
const MINION_PATH = "res://scenes/characters/Minion.tscn"
const ENDINGS_PATH = "res://scenes/Endings.tscn"
const BASE = "res://scenes/Base.tscn"

const RICH_ENDING = 700
const POOR_ENDING = 100
var money = 1000

const TOTAL_LEVELS = 5
var current_level = 0

onready var animation_player = get_node("Transition/AnimationPlayer")

export (float) var fade_time = 0.1

func _ready():
	call_deferred("init")

func _init():
	to_base()

func _process(delta):
	#get_node("UI/Money").text = "$" + str(money)
	add_minion()
	
	if current_level == TOTAL_LEVELS:
		if self.has_node("Level"):
			var lvl = get_node("Level")
			self.remove_child(lvl)
			lvl.queue_free()
		
		if self.has_node("Base"):
			var base = get_node("Base")
			self.remove_child(base)
			base.queue_free()
		
		var endings = load(ENDINGS_PATH).instance()
		
		#endings.ending_text = "Stupid"
		
		self.add_child(endings)

func load_level(num):
	if self.has_node("Level"):
		var lvl = get_node("Level")
		self.remove_child(lvl)
		lvl.queue_free()
	
	if self.has_node("Base"):
		var base = get_node("Base")
		self.remove_child(base)
		base.queue_free()
	
	current_level = num
	
	var lvl = load(LVL_PATH % num)
	
	if lvl != null:
		lvl = lvl.instance()
	
	self.add_child(lvl)
	
	return true

func to_base():
	if self.has_node("Level"):
		var lvl = get_node("Level")
		self.remove_child(lvl)
		lvl.queue_free()
	
	var base = load(BASE).instance()
	
	self.add_child(base)
	
	return true

func transition_to_level(lvl_num):
	yield(get_tree().create_timer(fade_time), "timeout")
	
	animation_player.play_backwards("fade")
	
	yield(animation_player, "animation_finished")
	load_level(lvl_num)
	animation_player.play("fade")
	yield(animation_player, "animation_finished")

func add_minion():
	if Input.is_action_just_pressed("ui_add_minion") and self.has_node("Level"):
		self.money -= 100
		var minion = load(MINION_PATH).instance()
		minion.position = Vector2(512, 384)
	
		get_node("Level/Characters").add_child(minion)
		return true
