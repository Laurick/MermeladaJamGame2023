extends Node

func _ready():
	$"/root/Audio".play_music("Moriegar1")
	$"/root/Audio".play_ui_sound("bufido1")
	
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == 1:
			get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _input(event):
	if event is InputEventKey:
		if event.key_label == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://scenes/main.tscn")
