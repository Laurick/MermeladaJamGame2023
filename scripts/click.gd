extends Node

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == 1:
			$"/root/Audio".play_random_click()
