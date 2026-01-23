extends CharacterBody2D

@export var PlayerMovementComponent: Node

func _physics_process(_delta: float) -> void:
	if velocity.x != 0:
		PlayerMovementComponent.facingDirection = velocity.x < 0
	$Sprite2D.flip_h = PlayerMovementComponent.facingDirection

func _on_damage_delt() -> void:
	modulate = Color(1.0, 0.3, 0.237, 1.0)
	await get_tree().create_timer(0.2).timeout
	modulate = Color.WHITE
