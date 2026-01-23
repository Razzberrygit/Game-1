extends CharacterBody2D
@export var movementComponent: MovementComponent
@export var wingAnimationTree: AnimationTree
@export var scrubberAnimationTree: AnimationTree

func _process(_delta: float) -> void:
	var flying: bool = movementComponent.isMoving()
	wingAnimationTree.set("parameters/conditions/fly", flying)
	wingAnimationTree.set("parameters/conditions/idle", !flying)
	
	
	scrubberAnimationTree.set("parameters/conditions/Spin", flying)
	scrubberAnimationTree.set("parameters/conditions/StopSpinning", !flying)

func _on_damage_delt() -> void:
	modulate = Color(1.0, 0.3, 0.237, 1.0)
	await get_tree().create_timer(0.2).timeout
	modulate = Color.WHITE

func _died() -> void:
	queue_free()
