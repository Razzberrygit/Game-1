extends Camera2D
@export var smoothingSpeed: float
@export var rightLimit: float = 100000000
@export var leftLimit: float = -100000000
@export var topLimit: float = -100000000
@export var bottemLimit: float = 100000000
@export var stillCameraPosition: Vector2 ##Can't be (0,0) or it will not be recognized
var usestillCameraPosition: bool
var halfScreenSize := DisplayServer.window_get_size()

# 0.56 zoom

func _ready() -> void:
	Global.camera = self
	ResetCamToPlayer()
	usestillCameraPosition = (stillCameraPosition == Vector2.ZERO)

func _physics_process(_delta: float) -> void:
	halfScreenSize = DisplayServer.window_get_size()
	
	if !usestillCameraPosition:
		global_position = stillCameraPosition
	else:
		global_position = global_position.lerp(_GetLimitedPosition(), smoothingSpeed)

func ResetCamToPlayer() -> void:
	global_position = _GetLimitedPosition()

func _GetLimitedPosition() -> Vector2:
	var limitedPosition := Vector2(clampf(Player.global_position.x, leftLimit + halfScreenSize.x, rightLimit  - halfScreenSize.x), 
								   clampf(Player.global_position.y, topLimit  + halfScreenSize.y, bottemLimit - halfScreenSize.y))
	return limitedPosition
