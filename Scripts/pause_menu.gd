extends CanvasLayer


func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused
	
	if get_tree().paused and Input.is_action_just_pressed("ui_cancel"):
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif not $"../UI/InventoryInterface".visible:
		hide()                                                  
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		hide()
