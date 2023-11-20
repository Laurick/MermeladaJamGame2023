extends Node

@export var all_tools: Array[Tool] 
@export var stuff: Array[Tool] 
var level_stuff: Array[Tool] 

var level: int
var tool_to_find: Tool
var tool_to_find_node

const MAX_LEVEL:int = 5

@onready var timer_bar: TextureProgressBar = $MarginContainer/game/VBoxContainer/Container2/TextureProgressBar
@onready var timer: Timer = $Timer
@onready var game: Node = $MarginContainer
@onready var box: Node = $MarginContainer/game/Control/TextureRect
@onready var tool_image: TextureRect = $MarginContainer/game/VBoxContainer/Container/tool

@onready var level_1_paw : TextureRect = $MarginContainer/game/VBoxContainer/HBoxContainer/TextureRect
@onready var level_2_paw : TextureRect = $MarginContainer/game/VBoxContainer/HBoxContainer/TextureRect2
@onready var level_3_paw : TextureRect = $MarginContainer/game/VBoxContainer/HBoxContainer/TextureRect3
@onready var level_4_paw : TextureRect = $MarginContainer/game/VBoxContainer/HBoxContainer2/TextureRect4
@onready var level_5_paw : TextureRect = $MarginContainer/game/VBoxContainer/HBoxContainer2/TextureRect5

@onready var cat: TextureRect = $cat
@onready var dialog_node: TextureRect = $dialog
@onready var dialog_label: Label = $dialog/Label
@onready var click_thief = $click_thief

var playing = false

var tool_node = load("res://scenes/tool.tscn")

var time_bar_rect

func _ready():
	time_bar_rect = timer_bar.get_rect()
	$"/root/Audio".play_music("miausionimpawsible")
	
func start_new_level():
	click_thief.mouse_filter = Control.MOUSE_FILTER_STOP
	playing = false
	#clear data
	level_stuff.clear()
	for child in box.get_children():
		box.remove_child(child)
		
	#pick random
	var index_rand = randi_range(0,all_tools.size()-1)
	tool_to_find = all_tools[index_rand]
	tool_to_find_node = instantiate_new_tool_on_box(tool_to_find)
	
	# fill the box with objects
	add_stuff_to_box()
	
	#tool_to_find_node.modulate = Color(0,1,0)
	tool_image.texture = tool_to_find.image
	tool_image.flip_h = randf() > 0.5
	tool_image.flip_v = randf() > 0.5
	
func _process(delta):
	if playing:
		timer_bar.value = timer.time_left

func add_stuff_to_box():
	for i in range((3*level)+6):
		var prob = randf() 
		var tool_to_spawn:Tool = null
		if prob > 0.4:
			tool_to_spawn = stuff[randi_range(0, stuff.size()-1)]
		else:
			while tool_to_spawn == null or tool_to_find.name == tool_to_spawn.name:
				tool_to_spawn = all_tools[randi_range(0,all_tools.size()-1)]
		instantiate_new_tool_on_box(tool_to_spawn)
		
func success_guess():
	match level:
		1:
			level_1_paw.start_secuence()
		2:
			level_2_paw.start_secuence()
		3:
			level_3_paw.start_secuence()
		4:
			level_4_paw.start_secuence()
		5:
			pass
			#level_5_paw.start_secuence()
		_:
			print("level? "+str(level))
	level+=1
	if level <= MAX_LEVEL:
		start_new_level()
		show_all_tools()
		$CatTimer2.start()
	else:
		game_win()

func show_all_tools():
	var delay:float = 0
	for c in box.get_children():
		c.show_tween(delay)
		delay += 0.2

func game_over():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
func game_win():
	get_tree().change_scene_to_file("res://scenes/game_win.tscn")

func _on_timer_timeout():
	game_over()

func _on_intro_intro_pressed():
	level = 1
	game.show()
	start_new_level()
	show_all_tools()
	$CatTimer2.start()
 
func instantiate_new_tool_on_box(tool_to_spawn:Tool) -> Control:
	var new_tool = tool_node.instantiate()
	new_tool.setup(tool_to_spawn)
	new_tool.tool_clicked.connect(_on_tool_clicked)
	var rect: Vector2 = box.get_rect().size
	var positioned = false
	var tool_original_position = new_tool.position
	var box_rect: Rect2 = box.get_global_rect()
	#print("name %s" % tool_to_spawn.name)
	var offset = 25
	box_rect.position = box_rect.position+Vector2(0,0)
	box_rect.size = box_rect.size-Vector2(offset*2,offset*2)
	#print("box_rect %s" % box_rect)
	while not positioned:
		#new_tool.rotation_degrees = randi_range(0, 360)
		new_tool.position = Vector2(randi_range(0, rect[0]), randi_range(0, rect[1]))
		var tool_rect:Rect2 = new_tool.get_global_rect()
		#print("tool_rect %s" % tool_rect)
		positioned = Constants.is_point_inside(box_rect, tool_rect.position)
		positioned = positioned && Constants.is_point_inside(box_rect, tool_rect.position+Vector2(tool_rect.size[0],0))
		positioned = positioned && Constants.is_point_inside(box_rect, tool_rect.position+Vector2(0, tool_rect.size[1]))
		positioned = positioned && Constants.is_point_inside(box_rect, tool_rect.position+Vector2(tool_rect.size[0], tool_rect.size[1]))
		
		#positioned = true
		#print("positioned %s" % positioned)
	box.add_child(new_tool)
	return new_tool

func _on_tool_clicked(tool:Tool):
#	print("on tool clicked: "+tool.name)
	if (tool.name == tool_to_find.name):
		timer.stop()
		success_guess()
	else:
		game_over()

func show_cat():
	var tween = get_tree().create_tween()
	cat.set_position(Vector2(-145, 600))
	tween.tween_property(cat, "position", Vector2(-145,-77), 0.5)
	tween.tween_callback(show_cat_text)

func hide_cat():
	dialog_node.hide()
	var tween = get_tree().create_tween()
	tween.tween_property(cat, "position", Vector2(-145, 600), 0.5)
	tween.tween_callback(start_game)

func start_game():
	click_thief.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var time = 2.5 - (level*0.2)
	#var time = 1000
	timer.wait_time = time
	timer.start()
	timer_bar.max_value = time
	timer_bar.value = time
	playing = true
	
func show_cat_text():
	dialog_label.text = tr("CAT"+str(randi_range(1,12)))
	dialog_node.show()
	$CatTimer.start()
	#move tool
	var rect: Vector2 = box.get_rect().size
	var positioned = false
	var tool_original_position = tool_to_find_node.position
	var box_rect: Rect2 = box.get_global_rect()
	#print("name %s" % tool_to_spawn.name)
	var offset = 25
	box_rect.position = box_rect.position+Vector2(0,0)
	box_rect.size = box_rect.size-Vector2(offset*2,offset*2)
	#print("box_rect %s" % box_rect)
	while not positioned:
		#new_tool.rotation_degrees = randi_range(0, 360)
		tool_to_find_node.position = Vector2(randi_range(0, rect[0]), randi_range(0, rect[1]))
		var tool_rect:Rect2 = tool_to_find_node.get_global_rect()
		#print("tool_rect %s" % tool_rect)
		positioned = Constants.is_point_inside(box_rect, tool_rect.position)
		positioned = positioned && Constants.is_point_inside(box_rect, tool_rect.position+Vector2(tool_rect.size[0],0))
		positioned = positioned && Constants.is_point_inside(box_rect, tool_rect.position+Vector2(0, tool_rect.size[1]))
		positioned = positioned && Constants.is_point_inside(box_rect, tool_rect.position+Vector2(tool_rect.size[0], tool_rect.size[1]))
	
	# re order for more evilness
	for tool in box.get_children():
		box.move_child(tool, randi_range(0,box.get_child_count()-1))

func _on_cat_timer_timeout():
	hide_cat()


func _on_cat_timer_2_timeout():
	show_cat()
