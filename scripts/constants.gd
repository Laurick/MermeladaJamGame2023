extends Node

const PURPLE:String = "#2A0059"
const CORAL:String = "#FFD0A0"
const ORANGE:String = "#DC4A00"

var fx = -1
var music = -1

func is_point_inside(rect: Rect2, point: Vector2) -> bool:
	var x = point[0]
	var y = point[1]
	#print("rect %s" % rect)
	#print("point %s" % point)
	return ((x >= rect.position[0] and x < rect.position[0]+rect.size[0]) and
		(y >= rect.position[1] and y < rect.position[1]+rect.size[1]))
