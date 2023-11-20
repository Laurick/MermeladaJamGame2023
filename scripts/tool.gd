extends TextureRect

signal tool_clicked(tool)

var tool:Tool
	
func setup(tool_setup:Tool):
	self.tool = tool_setup
	self.texture = tool_setup.image
	self.modulate = Color(1, 1, 1, 0)
	#self.flip_h = randf() > 0.5
	#self.flip_v = randf() > 0.5

func show_tween(delay: float):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.3)

func set_custom_modulate(color: Color):
	self.self_modulate = color
	
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == 1:
			var t: CompressedTexture2D = self.texture
			if t.get_image().get_pixel(event.position[0], event.position[1]).a  > 0.1:
				tool_clicked.emit(tool)
			else:
				var nodes = get_parent().get_children()
				for n in nodes:
					if n.comsume_unhandled_click():
						break

func comsume_unhandled_click() -> bool:
	var grect = get_global_rect();
	var mouse_position = get_viewport().get_mouse_position()
	if Constants.is_point_inside(grect, mouse_position):
		var t: CompressedTexture2D = self.texture
		var local_mouse_position = get_local_mouse_position()
		if t.get_image().get_pixel(local_mouse_position[0], local_mouse_position[1]).a  > 0.1:
			tool_clicked.emit(tool)
			return true
	return false
	# print("checking %s" % tool.name)
#	var x = event.global_position[0]
#	var y = event.global_position[1]
#	#print("click on %s" % str(event.global_position))
#	var grect = get_global_rect();
##	#print("rect %s" % str(grect))
#	if Constants.is_point_inside(grect, event.global_position):
#		print("event inside %s" % tool.name)
#		var t: CompressedTexture2D = self.texture
#		if t.get_image().get_pixel(event.position[1], event.position[0]).a  > 0.1:
#			print("has alpha %s" % t.get_image().get_pixel(event.position[0], event.position[1]).a)
#			self.modulate = Color(0,1,1,1)
#		else:
#			self.modulate = Color(1,1,1,1)
#			tool_clicked.emit(tool)
