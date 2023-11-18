extends Control

@onready var slider_music = $HBoxContainer/VBoxContainer/SliderMusic
@onready var slider_fsx = $HBoxContainer/VBoxContainer/SliderFSX

func _ready():
	TranslationServer.set_locale("es")
	$"/root/Audio".change_volume_music(1.25)
	# $"/root/Audio".play_music("test_music")

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_slider_fsx_value_setted(new_value):
	$"/root/Audio".change_volume_fsx(new_value)
	$"/root/Audio".play_ui_sound("test_click")

func _on_slider_music_value_update(new_value):
	$"/root/Audio".change_volume_music(new_value/8)

