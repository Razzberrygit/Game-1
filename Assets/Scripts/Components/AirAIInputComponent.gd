extends AIInputComponent
class_name AirAIInputComponent

@export var parent: CharacterBody2D
@export var navigationAgent: NavigationAgent2D
var followPath: bool = true
var followTargetOffset: Vector2
var followtargetNode: Node2D


func _process(_delta: float) -> void:
	if !followPath:
		return
	
	if followtargetNode != null:
		navigationAgent.target_position = followtargetNode.global_position + followTargetOffset
	if !navigationAgent.is_target_reached():
		moveDirection = to_local(navigationAgent.get_next_path_position()).normalized()

func SetFollowTargetNode(targetNode: Node2D) -> void:
	followtargetNode = targetNode

func StopNavigation() -> void:
	followPath = false
	moveDirection = Vector2.ZERO

func StartNavigation() -> void:
	followPath = true
