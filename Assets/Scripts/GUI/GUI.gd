extends CanvasLayer

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		visible = !visible

func _on_coal_button_down() -> void:
	Inventory.AddItem(0, 999)

func _on_change_scene_button_down() -> void:
	pass
