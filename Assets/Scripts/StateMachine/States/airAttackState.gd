extends State

@export var timerLength: float = 1.0
var timerCount: float

@export var movementComponent: MovementComponent

func EnteredState() -> void:
	timerCount = 0.0

func UpdateState(delta: float) -> void:
	if timerCount < timerLength:
		timerCount += delta
	else:
		stateMachine.TravelToState(nextState)
