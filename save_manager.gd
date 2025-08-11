extends Node

const SAVE_PATH = "user://save_game.save"

func save_game(position: Vector2) -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(position)
		file.close()
		print("Juego guardado!")

func load_game() -> Vector2:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var pos = file.get_var()
		file.close()
		print("Juego cargado!")
		return pos
	else:
		print("No hay partida guardada.")
		return Vector2.ZERO

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
