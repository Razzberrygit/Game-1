extends Node
class_name State

@export var lastState: State
@export var nextState: State
var stateMachine: StateMachine

func EnteredState() -> void:
	pass

func UpdateState(_delta: float) -> void:
	pass

func ExitedState() -> void:
	pass
