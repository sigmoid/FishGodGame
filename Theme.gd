extends AudioStreamPlayer


func _ready():
	play()
	finished.connect(replay)

func replay():
	await(get_tree().create_timer(4).timeout)
