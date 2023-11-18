extends Node

@export var all_tools: Array[Tool] 
@export var stuff: Array[Tool] 
var level_stuff: Array[Tool] 

var level: int
var tool_to_find: Tool

const MAX_LEVEL:int = 5

@onready var label_level: Label = $game/VBoxContainer/Label
@onready var timer: Timer = $Timer
@onready var game: Node = $game
@onready var box: Node = $game/Control/TextureRect
@onready var tool_image: TextureRect = $game/VBoxContainer/CenterContainer/tool

func start_new_level():
	#clear data
	level_stuff.clear()
	for child in box.get_children():
		box.remove_child(child)
		
	#pick random
	var index_rand = randi_range(0,all_tools.size()-1)
	tool_to_find = all_tools[index_rand]
	
	var tool_node = load("res://scenes/tool.tscn")
	
	#fill the box with objects
	for i in range((2*level)+4):
		var prob = randf() 
		var tool_to_spawn:Tool = null
		if prob > 0.4:
			tool_to_spawn = stuff[randi_range(0,stuff.size()-1)]
		else:
			while tool_to_find == tool_to_spawn or tool_to_spawn == null:
				tool_to_spawn = all_tools[randi_range(0,all_tools.size()-1)]
		var new_tool = tool_node.instantiate()
		new_tool.setup(tool_to_spawn)
		new_tool.tool_clicked.connect(_on_tool_clicked)
		box.add_child(new_tool)
	# movimiento del gato
	# luego comenzar
	print("tool to find: "+tool_to_find.name)
		
	tool_image.texture = tool_to_find.image
	label_level.text = "%d/%d" % [level,MAX_LEVEL]
	timer.wait_time = 17 - (level*2)
	timer.start()

func success_guess():
	level+=1
	if level > MAX_LEVEL:
		start_new_level()
	else:
		game_win()

func game_over():
	print("GAME OVER")
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
func game_win():
	print("WIN!")
	get_tree().change_scene_to_file("res://scenes/game_win.tscn")

func _on_timer_timeout():
	game_over()

func _on_intro_intro_pressed():
	level = 1
	game.show()
	start_new_level()

func _on_tool_clicked(tool:Tool):
	print("on tool clicked: "+tool.name)
	if (tool.name == tool_to_find.name):
		success_guess()
	else:
		game_over()
