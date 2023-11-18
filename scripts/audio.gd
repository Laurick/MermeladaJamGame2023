extends Node

@onready var music_player = $MusicAudioStreamPlayer
@onready var effects_player = $FSXAudioStreamPlayer

var dictionary_sounds:Dictionary = {}
var dictionary_music:Dictionary = {}

func _init():
	dictionary_music["test_music"] = preload("res://sounds/music/Retro Comedy.ogg")
	dictionary_sounds["test_click"] = preload("res://sounds/fsx/click3.ogg")
	
func play_ui_sound(key: String):
	effects_player.stream = dictionary_sounds[key]
	effects_player.play(0)
	
func play_music(key: String):
	music_player.stream = dictionary_music[key]
	music_player.play(0)

func change_volume_fsx(new_value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FSX"),linear_to_db(new_value))

func change_volume_music(new_value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(new_value))
