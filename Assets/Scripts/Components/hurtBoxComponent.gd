extends Area2D
class_name HurtBox

@export var contactDamage: float
@export var iFramesLength: float = 0.3
var iFrameTimer: float = 1
var invincible: bool = false
var areasInHurtBox: Array[Area2D]

@export var healthComponent: Node
@export var movementComponent: Node

func _process(delta: float) -> void:
	if iFrameTimer > 0:
		iFrameTimer -= delta
	else:
		invincible = false
	
	var greatestContactDamage: float
	for i in areasInHurtBox.size():
		greatestContactDamage = max(greatestContactDamage, areasInHurtBox[i].GetContactDamage())
	if greatestContactDamage > 0:
		DoDamage(greatestContactDamage)

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("GetContactDamage") && !area.healthComponent.isDead:
		areasInHurtBox.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area.has_method("GetContactDamage"):
		areasInHurtBox.erase(area)

func ApplyKnockback(force: float, direction: Vector2) -> void:
	if movementComponent != null && !invincible:
		movementComponent.AddForceInDirection(force, direction)

func GetContactDamage():
	return contactDamage

func DoDamage(damage: float):
	if !invincible:
		healthComponent.DoDamage(damage)
		ResetIFrameTimer()

func ResetIFrameTimer() -> void:
	invincible = true
	iFrameTimer = iFramesLength
