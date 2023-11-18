extends Control

@onready var credits_panel = $Panel
@onready var slider_music = $VBoxContainer/SliderMusic
@onready var slider_fsx = $VBoxContainer/SliderFSX

@onready var ui_sound = $AudioStreamPlayerFSX

func _ready():
	TranslationServer.set_locale("es")
	ui_sound.stream = load("res://sounds/fsx/click3.ogg")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(12))

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_button_credits_pressed():
	credits_panel.show()

func _on_slider_fsx_value_setted(new_value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FSX"),linear_to_db(new_value))
	ui_sound.play(0)

func _on_slider_music_value_update(new_value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(new_value/4))

