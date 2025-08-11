extends CharacterBody2D  

@export var speed := 150
var direccion := 0.0  
var jump := 350  
const gravity := 10  

@onready var anim := $AnimatedSprite2D  
@onready var jump_sound := $JumpSound
@onready var collect_sound := $RespawnSound
@onready var hud = get_tree().current_scene.get_node("HUD")

var was_on_floor := false  
var landing_timer := 0.0  
var landing_duration := 0.2  

func _ready():
	hud = get_tree().current_scene.get_node("HUD")
	if hud:
		hud.update_count(Global.cherries) # Usamos la global al iniciar

func add_coin(amount: int):
	Global.cherries += amount
	if hud:
		hud.update_count(Global.cherries)
	collect_sound.play()

func die():
	get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	direccion = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccion * speed
	
	if not is_on_floor():
		velocity.y += gravity
	else:
		velocity.y = 0

	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = -jump
		jump_sound.play()

	if is_on_floor() and not was_on_floor:
		landing_timer = landing_duration

	if landing_timer > 0:
		landing_timer -= delta

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

	if direccion != 0:
		anim.flip_h = direccion < 0

	was_on_floor = is_on_floor()
	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("save_game"):  # Q para guardar
		SaveManager.save_game(global_position)
	elif Input.is_action_just_pressed("load_game"):  # R para cargar
		if SaveManager.has_save():
				global_position = SaveManager.load_game()
		
		
func save_position():
	SaveManager.save_game(global_position)
	print("Posición guardada!")

func load_position():
	if SaveManager.has_save():
		var data = SaveManager.load_game()
		if "position" in data:
			global_position = data["position"]
			print("Posición cargada!")
		else:
			print("No hay partida guardada.")
