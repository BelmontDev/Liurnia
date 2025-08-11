extends Area2D

@export var next_level_scene := "res://LevelScenes/Level2/level_2.tscn"

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file(next_level_scene)
