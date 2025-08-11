extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		# Llama la función 'die' del jugador para que reaccione (puedes personalizar esto)
		if body.has_method("die"):
			body.die()
		else:
			# Si no tiene die(), simplemente recarga la escena actual
			get_tree().reload_current_scene()
