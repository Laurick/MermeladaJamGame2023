extends Control

@onready var slider_music = $VBoxContainer/HBoxContainer/SliderMusic
@onready var slider_fsx = $VBoxContainer/HBoxContainer/SliderFSX

func _ready():
	TranslationServer.set_locale("es")
	if $"/root/Constants".music > -1:
		slider_music.set_value($"/root/Constants".music)
	else:
		$"/root/Audio".change_volume_music(1.25)
	if $"/root/Constants".fx > -1:
		slider_fsx.set_value($"/root/Constants".fx)
	else:
		$"/root/Audio".change_volume_fsx(1.25)
	$"/root/Audio".play_music("fusionmusical")

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_slider_fsx_value_setted(new_value):
	$"/root/Constants".fx = new_value/4
	$"/root/Audio".change_volume_fsx(new_value/4)
	$"/root/Audio".play_ui_sound("taka")

func _on_slider_music_value_update(new_value):
	$"/root/Constants".music = new_value/8
	$"/root/Audio".change_volume_music(new_value/8)

