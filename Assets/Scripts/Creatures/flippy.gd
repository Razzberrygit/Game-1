extends CharacterBody2D
@export var movementComponent: MovementComponent
@export var wingAnimationTree: AnimationTree
@export var scrubberAnimationTree: AnimationTree
@export var stateMachine: StateMachine

func _process(_delta: float) -> void:
	wingAnimationTree.set("parameters/conditions/fly", true)
	wingAnimationTree.set("parameters/conditions/idle", false)
	
	
	var attacking: bool
	if stateMachine.currentState is AttackState:
		attacking = true
	scrubberAnimationTree.set("parameters/conditions/Spin", attacking)
	scrubberAnimationTree.set("parameters/conditions/StopSpinning", !attacking)

func _on_damage_delt() -> void:
	modulate = Color(1.0, 0.3, 0.237, 1.0)
	await get_tree().create_timer(0.2).timeout
	modulate = Color.WHITE

func _died() -> void:
	queue_free()
