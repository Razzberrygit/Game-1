extends Sprite2D

@export var z: float
@onready var basePosition = global_position
@onready var camera2D: Camera2D = $%Camera2D

func _process(_delta: float) -> void:
	var zFakedPosition = Vector2(lerp(basePosition, camera2D.global_position, z))
	global_position = zFakedPosition
