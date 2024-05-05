extends Node



@export
var speed = 10

@export 
var distance_threshold = 0.2

var target_pos = self.position



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.position.distance_to(target_pos) > distance_threshold:
		self.position += (target_pos - self.position).normalized() * speed * delta
	
func setTargetPosition(pos):
	target_pos = pos
	self.rotation = target_pos.angle_to_point(self.position)
