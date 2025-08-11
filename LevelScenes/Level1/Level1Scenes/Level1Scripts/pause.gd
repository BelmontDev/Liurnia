extends Control

@onready var player = get_tree().current_scene.get_node("Player")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("stop"):  # Ejemplo: tecla ESC para pausar/resumir
		pause_or_unpause()
	if Input.is_action_just_pressed("save_game"):  # Ejemplo: tecla Q para guardar
		save_game()

func pause_or_unpause():
	if get_tree().paused:
		$"." .hide()
		get_tree().paused = false
	else:
		$"." .show()
		get_tree().paused = true

func _on_pause_pressed() -> void:
	pause_or_unpause()

func _on_Save_pressed() -> void:
	save_game()

func save_game():
	if player:
		SaveManager.save_game(player.global_position)
		print("Partida guardada!")
	else:
		print("Jugador no encontrado")
