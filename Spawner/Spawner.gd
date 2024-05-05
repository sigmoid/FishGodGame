extends Node
class_name Spawner

@export var path:String = ""
@export var spawn_locations:Array[SpawnLocation]
@export var parent:Node
var packed_scene:PackedScene

func _ready():
	assert(path != "", "Item path must but set.")
	assert(parent != null, "parent must be set in the inspector.")
	packed_scene = load(path)

func spawn():
	randomize()
	var index = randi_range(0, len(spawn_locations)-1)
	var spawn_location = spawn_locations[index]
	var instance = packed_scene.instantiate()
	instance.global_position = spawn_location.get_random_location()
	add_child(instance)

func _input(event):
	if event.is_action_pressed("test"):
		spawn()

