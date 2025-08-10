extends Area2D

func _on_body_entered(body):
	if body.name == "Player":  # Si el nodo que entra se llama "Player"
		get_tree().reload_current_scene() # Reinicia el nivel
