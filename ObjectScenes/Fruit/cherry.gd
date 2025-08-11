extends Area2D

@export var value := 1

func _on_body_entered(body):
	if body.name == "Player":
		body.add_coin(value)
		queue_free()
