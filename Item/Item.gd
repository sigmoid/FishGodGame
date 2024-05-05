extends Area2D
class_name item

var tier:int = 0:
	set(v):
		tier = v
		collision_shape_2d.shape.radius = (tier+1)*16 
		queue_redraw()
	get:
		return tier
const COLORS:Array[Color] = [Color.FLORAL_WHITE,
Color.GREEN,Color.SKY_BLUE,Color.PURPLE,Color.GOLDENROD]

@export var collision_shape_2d:CollisionShape2D
var attach_target:Node2D
var velocity:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_circle(Vector2.ZERO,(tier+1)*16,COLORS[tier])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position += velocity
	if attach_target:
		velocity -= (position - attach_target.position).normalized()
	pass


func _on_area_entered(area):
	if area is item:
		if area.tier == tier:
			if name > area.name:
				tier = (tier + 1) % 5
			else:
				queue_free()
	else:
		if area is FishHitbox:
			attach_target = area.get_parent()
	pass # Replace with function body.
