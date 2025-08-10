extends CharacterBody2D

var speed = 80
var direction = 1
var start_x = 0
var move_range = 140
var player = null

func _ready():
	start_x = position.x
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0]
	$AnimatedSprite2D.play("Run")

func _physics_process(delta):
	velocity.x = speed * direction
	move_and_slide()

	# Revisar todas las colisiones actuales
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision:
			var col = collision.get_collider()
			if col == player:
				get_tree().reload_current_scene()
				return

	# Cambiar dirección cuando llegue al límite
	if position.x > start_x + move_range:
		direction = -1
		$AnimatedSprite2D.flip_h = false
	elif position.x < start_x - move_range:
		direction = 1
		$AnimatedSprite2D.flip_h = true
