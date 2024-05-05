extends Node2D
class_name Main

enum Modes {ATTRACT, REPEL}

var current_mode: int
var magnet_preload: PackedScene = preload("res://Magnet/Magnet.tscn")

func _ready():
	current_mode = Modes.ATTRACT

func toggle_mode():
	current_mode = Modes.ATTRACT if current_mode == Modes.REPEL \
			else Modes.REPEL

func spawn_magnet(pos: Vector2):
	var attracts = true if current_mode == Modes.ATTRACT else false
	var magnet = magnet_preload.instantiate()
	magnet.init(attracts, pos)
	add_child(magnet)

func _input(event):
	if event is InputEventMouseButton:
		spawn_magnet(event.global_position)
	if event.is_action_pressed("test"):
		toggle_mode()
		print(current_mode)
