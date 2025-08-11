extends Area2D

@export var next_level_scene := "res://LevelScenes/Level1/Level1Scenes/level_1.tscn"
@export var required_cherries := 5

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		if Global.cherries >= required_cherries:
			print("Ganaste")
			Global.cherries = 0  # Resetea cherries al ganar
			Global.collected_cherries.clear()  # Limpia las monedas recogidas para que vuelvan a aparecer
			get_tree().change_scene_to_file(next_level_scene)
		else:
			print("Te faltan cherries para ganar. Tienes:", Global.cherries)
