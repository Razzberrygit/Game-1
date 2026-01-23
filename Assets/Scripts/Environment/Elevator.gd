extends AnimatableBody2D

@onready var copperElevatorDoorR: AnimatedSprite2D = $CopperElevatorDoorR
@onready var copperElevatorDoorL: AnimatedSprite2D = $CopperElevatorDoorL
@onready var collisionDoorR: CollisionShape2D = $CollisionDoorR
@onready var collisionDoorL: CollisionShape2D = $CollisionDoorL
var doorsOpen: bool = true
@onready var doorsWereOpen:bool = doorsOpen

@export var backroundZ: float
@onready var backroundBasePosition = global_position - $SteamElevatorBackround.global_position

var timer
var timerStep: float
@export var elevatorWaitSeconds: float

@export var elevatorSpeed: float
var elevatorVelocity: float
@export var elevatorAcceleration: float
@export var floorPositions: Array
@export var floorAt: int
@onready var floorToMoveTo: int = floorAt
@export var elevatorUp: bool = true

@export var steamElevatorBackround: Sprite2D

signal _coal_can_be_inputed

func _ready() -> void:
	if floorAt == (floorPositions.size() - 1):
		elevatorUp = false
	if floorAt == 0:
		elevatorUp = true
	HandleBackroundParallax()

func _physics_process(delta: float) -> void:
	
	HandleBackroundParallax()
	_HandleAnimation()
	
	var doneWaiting: bool = ElevatorWait(delta)
	if floorToMoveTo != floorAt:
		if doneWaiting:
			elevatorVelocity = move_toward(elevatorVelocity, elevatorSpeed, elevatorAcceleration * delta)
			position = position.move_toward(floorPositions[floorToMoveTo], elevatorVelocity * delta)
			if position == floorPositions[floorToMoveTo]:
				floorAt = floorToMoveTo
				elevatorVelocity = 0
				_coal_can_be_inputed.emit()
	else:
		doorsOpen = true

func _HandleAnimation():
	if doorsOpen != doorsWereOpen:
		if (doorsOpen):
			copperElevatorDoorR.play("Open")
			copperElevatorDoorL.play("Open")
			collisionDoorR.disabled = true
			collisionDoorL.disabled = true
			Player.PlayerMovementComponent.checkStep = true
		else:
			copperElevatorDoorR.play("Close")
			copperElevatorDoorL.play("Close")
			collisionDoorR.disabled = false
			collisionDoorL.disabled = false
			Player.PlayerMovementComponent.checkStep = false
	doorsWereOpen = doorsOpen

func ElevatorWait(delta: float):
	if timerStep >= elevatorWaitSeconds:
		return true
	else:
		timerStep += delta
		return false

func _coal_inputed() -> void:
	if floorToMoveTo == floorAt:
		doorsOpen = false
		if elevatorUp:
			floorToMoveTo += 1
		else:
			floorToMoveTo -= 1
		if floorToMoveTo == (floorPositions.size() - 1) || floorToMoveTo == 0:
			elevatorUp = !elevatorUp
		timerStep = 0

func HandleBackroundParallax() -> void:
	if steamElevatorBackround != null:
		var zFakedPosition = Vector2(lerp(global_position, Global.camera.global_position, backroundZ))
		steamElevatorBackround.global_position = zFakedPosition - backroundBasePosition
