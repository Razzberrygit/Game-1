extends MovementComponent
class_name AirMovementComponent

func _physics_process(_delta: float) -> void:
	HandleSprint()
	
	HandleAirPositionSmoothing()
	
	parent.move_and_slide()

func HandleAirPositionSmoothing() -> void:
	parent.velocity = lerp(parent.velocity, inputComponent.moveDirection * speed, 0.1)
