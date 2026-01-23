extends Node2D
class_name HealthComponent

signal DamageDelt
signal Died

@export var maxHealth: float
@onready var currentHealth := maxHealth
var isDead: bool

func _process(_delta: float) -> void:
	if currentHealth <= 0 && !isDead:
		isDead = true
		Died.emit()

func DoDamage(damage: float):
	if damage > 0 && !isDead:
		currentHealth -= damage
		DamageDelt.emit()

func Heal(healAmmount: float):
	currentHealth += healAmmount

func SetHealth(value: float):
	currentHealth = value

func ResetHealth():
	currentHealth = maxHealth
	isDead = false
