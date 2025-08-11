extends Control

@onready var player = null

func _ready():
	# Buscar el jugador en la escena actual
	player = get_tree().current_scene.get_node("Player")
	visible = false
	get_tree().paused = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):  # Esc = ui_cancel
		if get_tree().paused:
			resume()
		else:
			pause()

func pause():
	visible = true
	get_tree().paused = true

func resume():
	visible = false
	get_tree().paused = false

func _on_save_game_pressed():
	if player:
		SaveManager.save_game(player.global_position)
		print("Partida guardada!")
	else:
		print("Jugador no encontrado")

func _on_resume_pressed():
	resume()

func _on_exit_pressed():
	get_tree().quit()
