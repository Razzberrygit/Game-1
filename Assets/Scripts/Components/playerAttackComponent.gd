extends Area2D
@export var damage: float
@export var knockbackForce: float
@export var kickbackForce: float
var ajustedKnockbackForce: float
var knockbackDirection: Vector2
@export var upAttackPosition: Vector2
@export var downAttackPosition: Vector2
@export var leftAttackPosition: Vector2
@export var rightAttackPosition: Vector2
@onready var collisionShape = get_child(0)
var pogo: bool

@export var inputComponent: InputComponent
@export var movementComponent: MovementComponent
@export var parent: CharacterBody2D

func _physics_process(_delta: float) -> void:
	collisionShape.disabled = true
	if inputComponent.attackJustPressed:
		Attack()

func Attack() -> void:
	pogo = false
	ajustedKnockbackForce = knockbackForce
	
	var attackPosition: Vector2
	if movementComponent.facingDirection:
		attackPosition = leftAttackPosition
		knockbackDirection = Vector2.LEFT
	else:
		attackPosition = rightAttackPosition
		knockbackDirection = Vector2.RIGHT
	
	if inputComponent.moveDirection.y == 1 and not parent.is_on_floor():
		attackPosition = downAttackPosition
		knockbackDirection = Vector2.DOWN
		pogo = true
	elif  inputComponent.moveDirection.y == -1:
		attackPosition = upAttackPosition
		knockbackDirection = Vector2.UP
	elif inputComponent.moveDirection.x == -1:
		attackPosition = leftAttackPosition
		knockbackDirection = Vector2.LEFT
	elif inputComponent.moveDirection.x == 1:
		attackPosition = rightAttackPosition
		knockbackDirection = Vector2.RIGHT
	position = attackPosition
	
	collisionShape.disabled = false

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("DoDamage"):
		area.ApplyKnockback(ajustedKnockbackForce, knockbackDirection)
		area.DoDamage(damage)
		movementComponent.AddForceInDirection(kickbackForce, -knockbackDirection)
		if (pogo):
			movementComponent.jump(movementComponent.jumpHight * 0.7)
