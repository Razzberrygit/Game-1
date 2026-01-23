extends CharacterBody2D

var facingDirection: bool

@onready var spriteOffset = $Sprite2D.offset
@onready var spriteBasePosition = $Sprite2D.position

func _physics_process(_delta: float) -> void:
	if velocity.x != 0:
		facingDirection = velocity.x < 0
	flipH(facingDirection)

func flipH(flipSide: bool) -> void:
	$Sprite2D.flip_h = flipSide
	if flipSide:
		$Sprite2D.position = spriteBasePosition + -spriteOffset * 2
	else:
		$Sprite2D.position = spriteBasePosition

func _died() -> void:
	queue_free()

func _on_damage_delt() -> void:
	modulate = Color(1.0, 0.3, 0.237, 1.0)
	await get_tree().create_timer(0.2).timeout
	modulate = Color.WHITE
