extends Area2D
class_name SpawnLocation

@onready var collision:= $CollisionShape2D 

func get_random_location() -> Vector2:
	randomize()
	var shape = collision.shape.size
	var location = collision.global_position
	var x = randf_range((-shape.x/2)+location.x, (shape.x/2)+location.x)
	var y = randf_range((-shape.y/2)+location.y, (shape.y/2)+location.y)
	return Vector2(x,y)

