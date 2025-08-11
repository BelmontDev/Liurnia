extends Area2D

@export var next_level_scene := "res://LevelScenes/Level1/Level1Scenes/level_1.tscn"
@export var required_cherries := 7

@onready var message_label := $Advice

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	message_label.text = ""

func _on_body_entered(body):
	if body.name == "Player":
		if Global.cherries >= required_cherries:
			message_label.text = ""
			print("Ganaste")
			Global.reset()  # Resetea cherries y collected_cherries
			get_tree().change_scene_to_file(next_level_scene)
		else:
			message_label.text = "Te faltan Cherries para ganar. Tienes: %d" % Global.cherries
