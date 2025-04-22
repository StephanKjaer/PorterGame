extends CharacterBody2D

@onready var inventory_manager = get_node("../InventoryManager") # Assuming InventoryManager is a sibling
# Or, if InventoryManager is a child of Player:
# @onready var inventory_manager = get_node("InventoryManager")


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
	
# In Player.gd, when picking up an item:
func _on_item_area_body_entered(body):
	if body == self:
		var item_node = get_parent()
		var item_data = item_node.item_data
		inventory_manager.add_item(item_data)
		item_node.queue_free()
		# The InventoryManager will be responsible for updating the UI later
