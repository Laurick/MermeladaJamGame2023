extends Control

signal intro_pressed

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			intro_pressed.emit()
			queue_free()
