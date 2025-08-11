extends Node

const SAVE_PATH := "user://save_game.save"

func save_game(position: Vector2, cherries: int) -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var data = {
			"position": position,
			"cherries": cherries
		}
		file.store_var(data)
		file.close()
		print("Partida guardada.")
	else:
		print("Error al guardar.")

func load_game() -> Dictionary:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var data = file.get_var()
		file.close()
		print("Partida cargada.")
		return data
	else:
		print("No hay partida guardada.")
		return {}
	
func has_save() -> bool:
	var dir = DirAccess.open("user://")
	if dir and dir.file_exists("save_game.save"):
		return true
	return false

func delete_save() -> void:
	var dir = DirAccess.open("user://")
	if dir and dir.file_exists("save_game.save"):
		dir.remove("save_game.save")
		print("Archivo de guardado eliminado.")
