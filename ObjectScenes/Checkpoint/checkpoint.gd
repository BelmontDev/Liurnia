extends Area2D

var next_level_scene_path = "res://LevelScenes/Level1/Level1Scenes/level_1.tscn"

func _ready():
	# En Godot 4, conectar así:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene(next_level_scene_path)
