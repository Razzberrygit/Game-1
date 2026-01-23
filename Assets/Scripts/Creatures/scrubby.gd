extends CharacterBody2D

@export var rightFootAnimatedSprite2D: AnimatedSprite2D
@export var leftFootAnimatedSprite2D: AnimatedSprite2D
@export var inputComponent: InputComponent
@export var healthComponent: HealthComponent
var rng = RandomNumberGenerator.new()
var notMovingMargin = 20

@export var smokeParticles: CPUParticles2D
@export var leftBubbleParticles: CPUParticles2D
@export var rightBubbleParticles: CPUParticles2D
@export var whiteCleanerParticles: CPUParticles2D
@export var spriteChunk: Node2D

func _ready() -> void:
	leftBubbleParticles.visible = true
	rightBubbleParticles.visible = true
	whiteCleanerParticles.visible = true

func _process(_delta: float) -> void:
	if velocity.x > notMovingMargin:
		rightFootAnimatedSprite2D.play("Scrub")
		leftFootAnimatedSprite2D.play("Scrub")
	elif velocity.x < -notMovingMargin:
		rightFootAnimatedSprite2D.play_backwards("Scrub")
		leftFootAnimatedSprite2D.play_backwards("Scrub")
	else:
		rightFootAnimatedSprite2D.play("Idle")
		leftFootAnimatedSprite2D.play("Idle")

func _physics_process(_delta: float) -> void:
	if smokeParticles && !healthComponent.isDead:
		var isMoving: bool = velocity.x > notMovingMargin || velocity.x < -notMovingMargin
		smokeParticles.emitting = isMoving
		SetCleanerParticlesEmission(isMoving && is_on_floor())
		var remapedVelocity = remap(clampf(velocity.x, -200, 200), -200, 200, 100, 200)
		smokeParticles.initial_velocity_max = remapedVelocity
		smokeParticles.initial_velocity_min = remapedVelocity

func _on_damage_delt() -> void:
	inputComponent.Idle = false
	spriteChunk.modulate = Color(1.0, 0.3, 0.237, 1.0)
	await get_tree().create_timer(0.2).timeout
	spriteChunk.modulate = Color.WHITE

func _died() -> void:
	if rng.randi_range(1, 2) == 1:
		dropCoal()
	spriteChunk.visible = false
	smokeParticles.emitting = false
	SetCleanerParticlesEmission(false)
	await get_tree().create_timer(smokeParticles.lifetime).timeout
	queue_free()

func dropCoal() -> void:
	var coal = load("res://Assets/Scenes/Scene Objects/Items/Coal.tscn")
	var instance = coal.instantiate()
	Global.currentScene.add_child(instance)
	instance.global_position = global_position
	var velocityDamp = 3
	instance.linear_velocity = (velocity / velocityDamp) + Vector2(rng.randf_range(-100, 100), rng.randf_range(-400, -300))

func SetCleanerParticlesEmission(emitting: bool) -> void:
	leftBubbleParticles.emitting = emitting
	rightBubbleParticles.emitting = emitting
	whiteCleanerParticles.emitting = emitting
