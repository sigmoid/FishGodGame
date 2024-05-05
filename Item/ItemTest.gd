extends Node2D

const ITEM_SCENE = preload("res://Item/Item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var new = ITEM_SCENE.instantiate()
		new.position = get_global_mouse_position()
		add_child(new)
