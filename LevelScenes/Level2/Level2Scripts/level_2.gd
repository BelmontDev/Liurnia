extends Node2D

@onready var pause_menu = preload("res://ObjectScenes/SMenu/pause_menu.tscn").instantiate()

func _ready():
	add_child(pause_menu)
	pause_menu.hide()  # Para que empiece oculto

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Esc por defecto
		if pause_menu.visible:
			pause_menu.hide()
			get_tree().paused = false
		else:
			pause_menu.show()
			get_tree().paused = true
