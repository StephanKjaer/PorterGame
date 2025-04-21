extends CharacterBody2D

@export var speed: float = 200.0

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if direction.length() > 0:
		velocity = direction.normalized() * speed # Use the base class 'velocity'

	move_and_slide()

	if Input.is_action_just_pressed("support_action"):
		_perform_support_action()

	if Input.is_action_just_pressed("weak_attack"):
		_perform_weak_attack()

	if Input.is_action_just_pressed("pickup_item"):
		_attempt_pickup()

func _perform_support_action() -> void:
	print("Porter uses a support action!")

func _perform_weak_attack() -> void:
	print("Porter performs a weak attack!")

func _attempt_pickup() -> void:
	print("Porter attempts to pick up an item!")
