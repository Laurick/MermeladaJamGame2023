extends TextureRect

func start_secuence():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0, 0), 0.3)
	tween.tween_callback(second_step)

func second_step():
	self.texture = load("res://images/ronda_2.png")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3)
