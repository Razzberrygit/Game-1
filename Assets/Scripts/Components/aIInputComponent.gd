extends InputComponent
class_name AIInputComponent

@export var doAIInput: bool = true
@export var Idle: bool
var space_state

func _ready() -> void:
	space_state = get_world_2d().direct_space_state
