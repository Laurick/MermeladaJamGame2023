extends HBoxContainer

@onready var slider: Slider = $HSlider
@onready var label: Label = $Label

signal value_setted(new_value)
signal value_update(new_value)

func _on_h_slider_drag_ended(value_changed):
	value_setted.emit(slider.value)

func _on_h_slider_value_changed(value):
	label.text = str(value)
	value_update.emit(value)
