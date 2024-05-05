extends Node



@export
var max_speed = 10

@export 
var distance_threshold = 0.2

@export 
var negative_distance_threshold = 400

@export
var rotate_duration = 0.5

var target_pos = self.position

var rotate_timer = 0.0

var target_rotation = 0.0

var prev_rotation = 0.0

var current_velocity = 0.0

@export
var acceleration = 10.0

var attraction = 0.0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rotate_timer > 0:
		self.rotation = lerp_angle(prev_rotation, target_rotation, self.ease(1.0 - (rotate_timer/rotate_duration)))
		rotate_timer -= delta
		
	if(current_velocity < max_speed):
		current_velocity += acceleration * delta * abs(attraction)
		
		if(current_velocity > max_speed):
			current_velocity = max_speed
		
	if attraction > 0 and self.position.distance_to(target_pos) > distance_threshold:
		self.position += (target_pos - self.position).normalized() * current_velocity * delta
	elif attraction < 0 && self.position.distance_to(target_pos) < negative_distance_threshold:
		self.position -= (target_pos - self.position).normalized() * current_velocity * delta
	else:
		
		current_velocity = 0.0
		
func setTargetPosition(pos, attr):
	target_pos = pos
	
	target_rotation = target_pos.angle_to_point(self.position)
	
	self.attraction = attr
	
	if(attraction < 0):
		target_rotation += PI
	
	prev_rotation = self.rotation
	rotate_timer = rotate_duration
	
func ease(x):
	return 1 - pow(1 - x, 3)
