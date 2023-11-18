extends TextureRect

signal tool_clicked(tool)

var tool:Tool

func setup(tool_setup:Tool):
	self.tool = tool_setup
	self.texture = tool_setup.image
	
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == 1:
			tool_clicked.emit(tool)
