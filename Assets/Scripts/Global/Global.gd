extends Node

var itemResourcePaths: Array[String] = [
	"res://Assets/Resources/Items/Coal.tres"
]

@onready var currentScene = get_tree().current_scene
const timeBetweenSceneChange = 0.3
var sceneChangeTimer: float = 1
var canChangeScene: bool

var camera: Camera2D
var playerSpawnUsed: bool

func _process(delta: float) -> void:
	if sceneChangeTimer > 0:
		sceneChangeTimer -= delta
	else:
		canChangeScene = true

func GetItemResourcePath(itemID: int):
	return itemResourcePaths[itemID]

func ChangeScene(scenePath: String, playerSpawnPosition: Vector2):
	if !canChangeScene:
		return
	get_tree().get_root().remove_child(currentScene)
	var sceneResource = load(scenePath)
	currentScene = sceneResource.instantiate()
	Player.global_position = playerSpawnPosition
	get_tree().get_root().add_child(currentScene)
	_ResetSceneChangeTimer()
	_UpdateSceneData()

func _UpdateSceneData() -> void:
	pass

func _ResetSceneChangeTimer() -> void:
	sceneChangeTimer = timeBetweenSceneChange
	canChangeScene = false
