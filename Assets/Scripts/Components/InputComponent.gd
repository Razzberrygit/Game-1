extends Node2D
class_name InputComponent

@export var DoPlayerInput: bool = true

var moveDirection: Vector2
var sprintPressed: bool
var jumpJustPressed: bool
var jumpJustReleased: bool
var attackJustPressed: bool

func _physics_process(_delta: float) -> void:
	HandlePlayerInput()

func HandlePlayerInput() -> void:
	if !DoPlayerInput:
		return
	
	moveDirection.y = round(Input.get_axis("moveUp", "moveDown"))
	moveDirection.x = round(Input.get_axis("moveLeft", "moveRight"))
	
	sprintPressed = Input.is_action_pressed("sprint")
	jumpJustPressed = Input.is_action_just_pressed("jump")
	jumpJustReleased = Input.is_action_just_released("jump")
	attackJustPressed = Input.is_action_just_pressed("attack")
	
	if Input.get_axis("moveUp", "moveDown") == -1:
		SignalBus.playerInteracted.emit()
