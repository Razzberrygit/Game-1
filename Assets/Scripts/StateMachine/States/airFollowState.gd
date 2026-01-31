extends State

@export var lookRadius: float
var squaredLookRadius: float
@export var followOffset: Vector2
var canAttack: bool = true
@export var timerLength: float = 1
var timerCount: float

func EnteredState() -> void:
	timerCount = 0.0
	squaredLookRadius = lookRadius*lookRadius
	stateMachine.airAIInputComponent.StartNavigation()
	stateMachine.airAIInputComponent.SetFollowTargetNode(Player)

func UpdateState(delta: float) -> void:
	stateMachine.airAIInputComponent.followTargetOffset = GetSidedFollowOffset(followOffset)
	
	if timerCount < timerLength:
		canAttack = false
		timerCount += delta
	else:
		canAttack = true
	
	if stateMachine.airAIInputComponent.navigationAgent.is_target_reached() && canAttack:
		stateMachine.TravelToState(nextState)

func ExitedState() -> void:
	stateMachine.airAIInputComponent.StopNavigation()

func GetSidedFollowOffset(offset: Vector2) -> Vector2:
	return Vector2(offset.x * -sign(Player.global_position.x - stateMachine.global_position.x), offset.y)
