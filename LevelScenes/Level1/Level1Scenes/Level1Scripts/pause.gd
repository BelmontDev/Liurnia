extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("stop"):
		pause_or_unpause()
		
		
func pause_or_unpause():
	if get_tree().paused == true:
		$".".hide()
		get_tree().paused = false
	elif get_tree().paused == false:
		$".".show()
		get_tree().paused = true

func _on_pause_pressed() -> void:
	pass # Replace with function body.


func _on_esc_pressed() -> void:
	pause_or_unpause()
	#function body.
