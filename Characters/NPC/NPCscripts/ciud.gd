extends Area2D

const INTERACT := "interact"

var player_in_range: bool = false
var dialogo_inicial := "Presiona E para interactuar"
var dialogo_final := "Tienes que recoger todas las Cherries para cambiar de nivel"

@onready var dialog_label: Label = $DialogoLabel
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D  # Cambia el nombre si usas otro

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	anim_sprite.play("idle")  # Aquí arrancas la animación idle

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		player_in_range = true
		mostrar_mensaje(dialogo_inicial)

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		player_in_range = false
		ocultar_mensaje()

func _process(delta: float) -> void:
	if player_in_range:
		if Input.is_action_just_pressed(INTERACT):
			print("Detecté E")
			mostrar_mensaje(dialogo_final)

func mostrar_mensaje(texto: String) -> void:
	dialog_label.text = texto
	dialog_label.visible = true

func ocultar_mensaje() -> void:
	dialog_label.visible = false
