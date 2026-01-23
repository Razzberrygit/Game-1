extends Node

@export var itemID: int
@export var itemCount: int

func _on_player_body_entered(_player: Node2D) -> void:
	Inventory.AddItem(itemID, itemCount)
	queue_free()
