extends AttackState

@export var timerLength: float = 2
var timerCount: float
@export var timerKey: float = 0.5
var keyBool: bool

func EnteredState() -> void:
	timerCount = 0.0
	keyBool = false
	if Player.global_position.x <= stateMachine.global_position.x:
		stateMachine.airAIInputComponent.moveDirection.x = 1
	else:
		stateMachine.airAIInputComponent.moveDirection.x = -1

func UpdateState(delta: float) -> void:
	if timerCount >= timerKey && !keyBool:
		attacking = true
		keyBool = true
		if Player.global_position.x > stateMachine.global_position.x:
			stateMachine.airAIInputComponent.moveDirection.x = 1
		else:
			stateMachine.airAIInputComponent.moveDirection.x = -1
		stateMachine.airAIInputComponent.sprintPressed = true
	
	if timerCount < timerLength:
		timerCount += delta
	else:
		stateMachine.TravelToState(nextState)

func ExitedState() -> void:
	attacking = false
	stateMachine.airAIInputComponent.moveDirection.x = 0
	stateMachine.airAIInputComponent.sprintPressed = false

func _on_damage_delt() -> void:
	stateMachine.TravelToState(nextState)
