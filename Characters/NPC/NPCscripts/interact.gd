extends CanvasLayer

@onready var dialog_label: Label = $DialogoLabel

func mostrar_mensaje(texto: String) -> void:
	dialog_label.text = texto
	dialog_label.visible = true

func ocultar_mensaje() -> void:
	dialog_label.visible = false
