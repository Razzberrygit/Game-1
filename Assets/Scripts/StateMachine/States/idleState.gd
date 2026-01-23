extends State

@export var lookRadius: float
var squaredLookRadius: float

func EnteredState() -> void:
	squaredLookRadius = lookRadius*lookRadius

func UpdateState(_delta: float) -> void:
	if stateMachine.CheckCircleForPlayer(squaredLookRadius):
		stateMachine.TravelToState(nextState)
