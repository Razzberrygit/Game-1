extends Node2D
class_name StateMachine

@export var currentState: State

@export var airAIInputComponent: AirAIInputComponent
@export var movementComponent: MovementComponent

func _ready() -> void:
	currentState = get_child(0)
	currentState.EnteredState()
	for i in get_children().size():
		get_children()[i].stateMachine = self

func _physics_process(delta: float) -> void:
	currentState.UpdateState(delta)

func TravelToState(state: State) -> void:
	if state == null:
		return
	currentState.ExitedState()
	currentState = state
	currentState.EnteredState()

func CheckCircleForPlayer(squaredRadiusToCheck: float) -> bool:
	var squaredDistance := global_position.distance_squared_to(Player.global_position)
	return squaredDistance < squaredRadiusToCheck
