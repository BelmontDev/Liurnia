extends AnimatableBody2D

@export var move_speed = 0.5

@onready var path_follow : PathFollow2D = get_parent()

var path_directions = 1

func _physics_process(delta: float) -> void:
	path_follow.progress += move_speed * path_directions 
	var new_progress_ratio = path_follow.progress_ratio
	if new_progress_ratio == 0 || new_progress_ratio == 1 : 
		path_directions *= -1
