extends Node2D
class_name MovementComponent

@export var walkSpeed: float = 200
@export var sprintSpeed: float = 400
@export var maxVelocity: float = 4000
@onready var speed: float = walkSpeed
var facingDirection: bool
var VerticalKnockbackDamp: float = 1.0
var velocityStopedRange: float = 50

@export var parent: CharacterBody2D
@export var inputComponent: Node

func HandleSprint() -> void:
	if inputComponent.sprintPressed:
		speed = sprintSpeed
	else:
		speed = walkSpeed

func AddForceInDirection(force: float, direction: Vector2) -> void:
	parent.velocity.x += direction.x * force
	parent.velocity.y += direction.y * force * VerticalKnockbackDamp

func isMoving() -> bool:
	var isMovingOnX: bool = parent.velocity.x > velocityStopedRange || parent.velocity.x < -velocityStopedRange
	var isMovingOnY: bool = parent.velocity.y > velocityStopedRange || parent.velocity.y < -velocityStopedRange
	return isMovingOnX || isMovingOnY
