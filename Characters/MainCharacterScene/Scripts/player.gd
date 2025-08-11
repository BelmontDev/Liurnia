extends CharacterBody2D  

var speed := 150  
var direccion := 0.0  
var jump := 350  

const gravity := 10  

@onready var anim := $AnimatedSprite2D  
@onready var jump_sound := $JumpSound
@onready var collect_sound := $RespawnSound

var was_on_floor := false  
var landing_timer := 0.0  
var landing_duration := 0.2  

var cherries := 0
var hud = null

func _ready():
	hud = get_tree().current_scene.get_node("HUD")
	if hud:
		hud.update_count(cherries)
	# No carga partida aquí, solo al presionar 'R'

func add_coin(amount: int):
	cherries += amount
	if hud:
		hud.update_count(cherries)
	collect_sound.play()

func die():
	get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	# Movimiento horizontal
	direccion = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccion * speed
	
	# Aplicar gravedad si no está en el suelo
	if not is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 0  # Resetea la velocidad vertical en el suelo

	# Saltar
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = -jump
		jump_sound.play()

	# Detectar aterrizaje: cuando antes no estaba en el suelo y ahora sí
	if is_on_floor() and not was_on_floor:
		landing_timer = landing_duration

	# Actualizar timer para animación de aterrizaje
	if landing_timer > 0:
		landing_timer -= delta

	# Control de animaciones con prioridad
	if landing_timer > 0:
		anim.play("Land")
	elif not is_on_floor():
		if velocity.y < 0:
			anim.play("Jump")
		else:
			anim.play("Fall")
	else:
		if direccion == 0:
			anim.play("Idle")
		else:
			anim.play("Walk")

	# Voltear sprite según dirección
	if direccion != 0:
		anim.flip_h = direccion < 0

	# Guardar estado anterior de suelo para detectar cambios
	was_on_floor = is_on_floor()

	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("save_game"):  # Q para guardar
		save_position()
	if Input.is_action_just_pressed("load_game"):  # R para cargar
		load_position()

func save_position():
	SaveManager.save_game(global_position, cherries)
	print("Juego guardado!")

func load_position():
	if SaveManager.has_save():
		var save_data = SaveManager.load_game()
		if save_data.has("position") and save_data.has("cherries"):
			global_position = save_data["position"]
			cherries = save_data["cherries"]
			if hud:
				hud.update_count(cherries)
			print("Juego cargado!")
	else:
		print("No hay partida guardada.")
