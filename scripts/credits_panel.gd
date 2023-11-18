extends Panel

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == 1:
			self.hide()
	
func _input(event):
	if event is InputEventKey:
		if event.key_label == KEY_ESCAPE:
			self.hide()
