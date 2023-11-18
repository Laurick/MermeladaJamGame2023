extends Control

signal intro_pressed

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			print("clicked")
			self.mouse_filter = Control.MOUSE_FILTER_PASS
			self.hide()
			intro_pressed.emit()
