extends Node2D
class_name Main

enum Modes {ATTRACT, REPEL}

@onready var sprite:= $Sprite2D

var current_mode: int
var magnet_preload: PackedScene = preload("res://Magnet/Magnet.tscn")
var indicator_preload: PackedScene = preload("res://Magnet/Indicator.tscn")
var plus_texture: Texture = preload("res://Assets/Plus.png")
var minus_texture: Texture = preload("res://Assets/Minus.png")

func _ready():
	current_mode = Modes.ATTRACT

func toggle_mode():
	if current_mode == Modes.ATTRACT:
		current_mode = Modes.REPEL
		sprite.texture = minus_texture
	else:
		current_mode = Modes.ATTRACT
		sprite.texture = plus_texture

func spawn_magnet(pos: Vector2):
	var attracts = true if current_mode == Modes.ATTRACT else false
	var magnet = magnet_preload.instantiate()
	magnet.init(attracts, pos)
	add_child(magnet)
	var indicator = indicator_preload.instantiate()
	indicator.init(pos)
	add_child(indicator)
	

func _input(event):
	if event is InputEventMouseButton:
		spawn_magnet(event.global_position)
	if event.is_action_pressed("test"):
		toggle_mode()
		print(current_mode)
