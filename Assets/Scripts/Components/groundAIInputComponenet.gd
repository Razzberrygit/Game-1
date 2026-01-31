extends AIInputComponent

@export var wallRayLength: float = 200
@export var floorRayX: float = 200
@onready var halfParentWidth: float = collisionShape.shape.get_rect().size.x / 2
@onready var halfParentHight: float = collisionShape.shape.get_rect().size.y / 2

@export var collisionShape: CollisionShape2D
@export var parent: CharacterBody2D

func _process(_delta: float) -> void:
	if !Idle:
		HandlePatrol()
	else:
		moveDirection.x = 0

func HandlePatrol() -> void:
	if moveDirection.x == 0:
		moveDirection.x = 1
	var highWallRayQuery = PhysicsRayQueryParameters2D.create(parent.global_position + Vector2(0, -(halfParentHight - 1)), 
															  parent.global_position + Vector2(moveDirection.x * (wallRayLength + halfParentWidth), -(halfParentHight - 1)), 0b11100)
	var lowWallRayQuery = PhysicsRayQueryParameters2D.create(parent.global_position + Vector2(0, (halfParentHight - 1)), 
															 parent.global_position + Vector2(moveDirection.x * (wallRayLength + halfParentWidth), (halfParentHight - 1)), 0b11100)
	var floorRayQuery = PhysicsRayQueryParameters2D.create(parent.global_position + Vector2(moveDirection.x * floorRayX, 0), parent.global_position + Vector2(moveDirection.x * (floorRayX + halfParentWidth), halfParentHight + 10), 0b100)
	highWallRayQuery.collide_with_areas = true
	lowWallRayQuery.collide_with_areas = true
	floorRayQuery.collide_with_areas = true
	if space_state.intersect_ray(highWallRayQuery) || space_state.intersect_ray(lowWallRayQuery) || (!space_state.intersect_ray(floorRayQuery) && parent.is_on_floor()):
		moveDirection.x = moveDirection.x * -1
