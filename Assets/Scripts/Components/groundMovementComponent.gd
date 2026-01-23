extends MovementComponent
class_name GroundMovementComponent

enum GroundMovement {FULL_LIMBS, ONE_ARM, NO_LIMBS, WALK, DISABLED}

@export var groundMovementType := GroundMovement.FULL_LIMBS
@export var stepCheckHight: float = 200
var checkStep := true
var minYVelocityForCheckStep: float = 500
var jumpHight: float = 2000
var wallJumpStrength: float = 2000
var IsOnWall: bool
@onready var halfPlayerWidth: float = collisionShape.shape.get_rect().size.x / 2
@onready var halfPlayerHight: float = collisionShape.shape.get_rect().size.y / 2
var space_state: PhysicsDirectSpaceState2D

@export var collisionShape: CollisionShape2D

func _ready() -> void:
	space_state = get_world_2d().direct_space_state
	if stepCheckHight <= 0:
		checkStep = false
	VerticalKnockbackDamp = 0.3

func _physics_process(delta: float) -> void:
	match groundMovementType:
		GroundMovement.FULL_LIMBS:
			HandleFullLimbsMovement(delta)
		GroundMovement.ONE_ARM:
			HandleOneArmMovement(delta)
		GroundMovement.WALK:
			HandleWalkMovement(delta)
		GroundMovement.DISABLED:
			pass
	
	parent.move_and_slide()

func HandleWalkMovement(delta: float) -> void:
	IsOnWall = DirectionWallCheck()
	
	HandleGravity(delta)
	
	HandleGroundPositionSmoothing() 

func HandleOneArmMovement(delta: float) -> void:
	IsOnWall = DirectionWallCheck()
	
	HandleGravity(delta)
	
	HandleGroundPositionSmoothing()

func HandleFullLimbsMovement(delta: float) -> void:
	IsOnWall = DirectionWallCheck()
	
	HandleGravity(delta)
	
	HandleSprint()
	
	HandleWallDrag()
	
	HandleJumping()
	
	HandleGroundPositionSmoothing()

func DirectionWallCheck():
	if !parent.is_on_wall():
		return false
	
	var directionToCheck: int
	if facingDirection:
		directionToCheck = -1
	else:
		directionToCheck = 1
	
	StepCheck(directionToCheck)
	
	return WallClimbCheck(directionToCheck)

func HandleGroundPositionSmoothing() -> void:
	if parent.is_on_floor():
		parent.velocity.x = lerpf(parent.velocity.x, inputComponent.moveDirection.x * speed, 0.2)
	else:
		parent.velocity.x = lerpf(parent.velocity.x, inputComponent.moveDirection.x * speed, 0.1)

func HandleGravity(delta: float) -> void:
	if not parent.is_on_floor() and not IsOnWall:
		parent.velocity += parent.get_gravity() * delta
		if parent.velocity.y > maxVelocity:
			parent.velocity.y = maxVelocity

func HandleWallDrag() -> void:
	if IsOnWall and not parent.is_on_floor():
		var wallFriction := 0.2
		parent.velocity.y = lerpf(parent.velocity.y, 0, wallFriction)

func HandleJumping() -> void:
	if inputComponent.jumpJustPressed:
		if parent.is_on_floor():
			jump(jumpHight)
		elif IsOnWall:
			WallJump(jumpHight, wallJumpStrength)
	elif parent.velocity.y < 0 and !IsOnWall:
		if inputComponent.jumpJustReleased:
			var variableJumpValue = 0.2
			parent.velocity.y *= variableJumpValue

func jump(hight: float) -> void:
	parent.velocity.y = -hight

func WallJump(hight: float, pushoffStrength) -> void:
	jump(hight)
	if facingDirection:
		parent.velocity.x = pushoffStrength
	else:
		parent.velocity.x = -pushoffStrength

func WallClimbCheck(directionToCheck: int):
	var wallRayQueryTop = PhysicsRayQueryParameters2D.create(parent.global_position + Vector2(0, 0), parent.global_position + Vector2((halfPlayerWidth + 10) * directionToCheck, 0), 0b100)
	var wallRayQueryBottom = PhysicsRayQueryParameters2D.create(parent.global_position + Vector2(0, halfPlayerHight), parent.global_position + Vector2((halfPlayerWidth + 10) * directionToCheck, halfPlayerHight), 0b100)
	var canWallClimb = space_state.intersect_ray(wallRayQueryTop) && space_state.intersect_ray(wallRayQueryBottom) && parent.is_on_wall()
	return canWallClimb

func StepCheck(directionToCheck: int) -> void:
	if (!checkStep || abs(parent.velocity.y) > minYVelocityForCheckStep):
		return
	
	var stepHight: float
	if parent.is_on_floor():
		stepHight = stepCheckHight
	else:
		stepHight = stepCheckHight / 4
	var rayStart = parent.global_position + Vector2((halfPlayerWidth + 5) * directionToCheck, halfPlayerHight - stepHight)
	var rayEnd = parent.global_position + Vector2((halfPlayerWidth + 5) * directionToCheck, halfPlayerHight)
	var wallRayQuery = PhysicsRayQueryParameters2D.create(rayStart, rayEnd, 0b100)
	var result = space_state.intersect_ray(wallRayQuery)
	if result:
		parent.velocity.y = 0
		parent.global_position += Vector2(1 * directionToCheck, result.position.y - parent.global_position.y - halfPlayerHight - 20)
