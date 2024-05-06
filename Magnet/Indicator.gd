extends Node2D
class_name Indicator

func init(_position):
	global_position = _position

func _ready():
	z_index = -1
	await(get_tree().create_timer(0.5).timeout)
	queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 10, Color("a835f0", 0.5))
