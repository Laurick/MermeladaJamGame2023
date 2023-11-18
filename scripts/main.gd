extends Control

@onready var credits_panel = $Panel

func _ready():
	TranslationServer.set_locale("es")

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_button_credits_pressed():
	credits_panel.show()
