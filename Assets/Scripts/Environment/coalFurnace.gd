extends Sprite2D

@export var coalNeeded: int
var playerInRange: bool
var canInputCoal: bool = true
signal _coal_inputed

func _ready() -> void:
	SignalBus.playerInteracted.connect(_player_interacted)

func _player_interacted() -> void:
	if playerInRange and Inventory.HasItemCount(0, coalNeeded) and canInputCoal:
		Inventory.SubtractItem(0, coalNeeded)
		canInputCoal = false
		_coal_inputed.emit()

func _on_body_entered(_body: Node2D) -> void:
	playerInRange = true

func _on_body_exited(_body: Node2D) -> void:
	playerInRange = false

func _coal_can_be_inputed() -> void:
	canInputCoal = true
