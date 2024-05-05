extends Node

@onready var fish = $".."

@export 
var maxDist = 100.0
@export 
var minDist = 10.0

@export
var random_time_offset = 0.2

@export
var resetDuration = 3.0

var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = randf() *  random_time_offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	
	if(timer <= 0):
		timer = resetDuration + randf() * random_time_offset
		
		setNewPosition()
		
func setNewPosition():
	var theta = randf_range(0, 2 * PI)
	
	var newPos = fish.position
	
	var dist = randf_range(1, maxDist)
	
	newPos += Vector2(cos(theta), sin(theta)) * dist
	
	fish.setTargetPosition(newPos) 
		
	
		
