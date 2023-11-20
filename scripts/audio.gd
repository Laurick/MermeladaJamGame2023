extends Node

@onready var music_player = $MusicAudioStreamPlayer
@onready var effects_player = $FSXAudioStreamPlayer

var dictionary_sounds:Dictionary = {}
var dictionary_music:Dictionary = {}

func _init():
	dictionary_music["croquetillas"] = preload("res://sounds/music/croquetillas.ogg")
	dictionary_music["fusionmusical"] = preload("res://sounds/music/fusionmusical.ogg")
	dictionary_music["Moriegar1"] = preload("res://sounds/music/Moriegar1.ogg")
	dictionary_music["miausionimpawsible"] = preload("res://sounds/music/miausionimpawsible.mp3")
	
	
	dictionary_sounds["taka"] = preload("res://sounds/fsx/taka.ogg")
	dictionary_sounds["pi"] = preload("res://sounds/fsx/pi.ogg")
	dictionary_sounds["miuuuu"] = preload("res://sounds/fsx/miuuuu.ogg")
	dictionary_sounds["miniiiiau"] = preload("res://sounds/fsx/miniiiiau.ogg")
	dictionary_sounds["mimimimi"] = preload("res://sounds/fsx/mimimimi.ogg")
	dictionary_sounds["miau3"] = preload("res://sounds/fsx/miau3.ogg")
	dictionary_sounds["miau2"] = preload("res://sounds/fsx/miau2.ogg")
	dictionary_sounds["miau1"] = preload("res://sounds/fsx/miau1.ogg")
	dictionary_sounds["fiu_fiu_fiu_jgjgjg"] = preload("res://sounds/fsx/fiu_fiu_fiu_jgjgjg.ogg")
	dictionary_sounds["click"] = preload("res://sounds/fsx/click.ogg")
	dictionary_sounds["bufido1"] = preload("res://sounds/fsx/bufido1.ogg")
	dictionary_sounds["sairaa"] = preload("res://sounds/fsx/sairaa.ogg")
	dictionary_sounds["bardo1"] = preload("res://sounds/fsx/bardo1.ogg")
	dictionary_sounds["bardo2"] = preload("res://sounds/fsx/bardo2.ogg")
	dictionary_sounds["miauclick"] = preload("res://sounds/fsx/miauclick.ogg")
	dictionary_sounds["clock"] = preload("res://sounds/fsx/clock.ogg")
	dictionary_sounds["miu"] = preload("res://sounds/fsx/miu.ogg")
	
var click_sounds = ["clock", "miu", "taka", "pi", "miuuuu", "miniiiiau", "miau3", "miau2", "miau1", "click", "sairaa", "miauclick"]

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

func play_random_click():
	var key = click_sounds[randi_range(0, click_sounds.size()-1)]
	effects_player.stream = dictionary_sounds[key]
	effects_player.play(0)
