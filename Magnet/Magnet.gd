extends Area2D
class_name Magnet

signal attract(strength: int)

@export var attracts:= true
@export var radius:= 200.0
@onready var collision:= $CollisionShape2D
var areas_detected:= false

func init(_attracts: bool, _position):
	global_position = _position
	attracts = _attracts

func _ready():
	collision.shape.radius = radius
	await get_tree().create_timer(1.0).timeout
	queue_free()

func get_strength(object) -> float:
	var polarity = (int(attracts) * 2) - 1
	var distance = global_position.distance_to(object.global_position)
	if distance > radius:
		return 0.0
	return (distance / radius) * polarity

func _physics_process(delta):
	if len(get_overlapping_areas()) == 0:
		return
	for area in get_overlapping_areas():
		if not area is FishHitbox:
			continue
		var fish = area.get_parent()
		var strength = get_strength(fish)
		fish.setTargetPosition(global_position, strength)
	set_physics_process(false)


