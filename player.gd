extends CharacterBody2D

@export var inventory_data: InventoryData
@export var speed: float = 200.0
@onready var interact_ray = $Camera2D/InteractRay

signal toggle_inventory()


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
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()

	if Input.is_action_just_pressed("interact"): # Corrected action name
		interact()

	if direction.length() > 0:
		velocity = direction.normalized() * speed # Use the base class 'velocity'
	else:
		velocity = Vector2.ZERO # Stop movement when no input

	move_and_slide()
	
	
func interact():
	if interact_ray.is_colliding():
		print("interract with", interact_ray.get_collider() )
