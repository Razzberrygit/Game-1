extends Node2D

func _ready() -> void:
	if !Global.playerSpawnUsed:
		Player.global_position = global_position
		Global.playerSpawnUsed = true
	queue_free()
