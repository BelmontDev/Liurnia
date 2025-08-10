extends CharacterBody2D  

var speed := 150  
var direccion := 0.0  
var jump := 300  
var cherry := 0

const gravity := 10  

@onready var anim := $AnimatedSprite2D  

var was_on_floor := false  
var landing_timer := 0.0  
var landing_duration := 0.2  

var hud = null

func _ready():
	hud = get_tree().current_scene.get_node("HUD")

func add_coin(amount: int):
	cherry += amount
	print("Cherry: ", cherry)
	
	if hud:
		hud.update_count(cherry)


func die():
	get_tree().reload_current_scene()
	
	
func _physics_process(delta: float) -> void:
	direccion = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccion * speed

	if landing_timer > 0:
		landing_timer -= delta
		if landing_timer <= 0:
			anim.play("Idle" if direccion == 0 else "Walk")
			landing_timer = 0

	if not is_on_floor():
		anim.play("Jump")
	elif direccion != 0 and landing_timer <= 0:
		anim.play("Walk")
	elif landing_timer <= 0:
		anim.play("Idle")

	if direccion != 0:
		anim.flip_h = direccion < 0

	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = -jump
		anim.play("Jump")

	if not is_on_floor():
		velocity.y += gravity

	if is_on_floor() and not was_on_floor and landing_timer <= 0:
		anim.play("Land")
		landing_timer = landing_duration

	was_on_floor = is_on_floor()

	move_and_slide()
	
