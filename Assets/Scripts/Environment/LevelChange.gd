extends Area2D

@export_multiline var pathToChangeTo: String
@export var newPlayerPosition: Vector2
var playerInArea

func _physics_process(_delta: float) -> void:
	if playerInArea:
		Global.ChangeScene.bind(pathToChangeTo, newPlayerPosition).call_deferred()

func _on_player_entered(_body: Node2D) -> void:
	playerInArea = true

func _on_player_exited(_body: Node2D) -> void:
	playerInArea = false
