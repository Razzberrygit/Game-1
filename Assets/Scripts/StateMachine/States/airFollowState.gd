extends State

@export var lookRadius: float
var squaredLookRadius: float

func EnteredState() -> void:
	squaredLookRadius = lookRadius*lookRadius
	stateMachine.airAIInputComponent.StartNavigation()

func UpdateState(_delta: float) -> void:
	stateMachine.airAIInputComponent.SetFollowTargetNode(Player)
	
	if stateMachine.CheckCircleForPlayer(squaredLookRadius):
		stateMachine.TravelToState(nextState)

func ExitedState() -> void:
	stateMachine.airAIInputComponent.StopNavigation()
