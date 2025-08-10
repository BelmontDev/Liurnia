extends Area2D

@export var value: int = 1  # valor de la moneda

func _on_body_entered(body):
	if body.name == "Player":
		body.add_coin(value) # Llamar función del jugador para sumar monedas
		queue_free() # Eliminar la moneda
