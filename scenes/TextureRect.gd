extends TextureRect

var time

# Called when the node enters the scene tree for the first time.
func _ready():
	time = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time == 10:
		position = Vector2((position.x + 1), position.y)
		time = 0
	time = time +1
