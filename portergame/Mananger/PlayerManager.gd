extends Node

@export var player_path: NodePath
var player

@onready var stamina_bar: ProgressBar = $"/root/Main/Player/BarUI/StaminaBar"
@onready var mana_bar: ProgressBar = $"/root/Main/Player/BarUI/ManaBar"
@onready var health_bar: ProgressBar = $"/root/Main/Player/BarUI/HealthBar"

func _ready():
	player = get_node("/root/Main/Player")
	
	if player:
		player.connect("stats_changed", Callable(self, "update_bars"))
		player.connect("move_player", Callable(self, "move_player"))
	update_bars()

func update_bars():
	if player:
		health_bar.value = float(player.health) / player.max_health
		mana_bar.value = float(player.mana) / player.max_mana
		stamina_bar.value = float(player.stamina) / player.max_stamina
	else:
		printerr("Player reference not set in PlayerManager.")

func move_player(_delta, current_speed):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var _cameraPivotY = player.get_node("CameraPivotY")
	var direction = (_cameraPivotY.global_transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()

	if direction:
		player.velocity.x = direction.x * current_speed
		player.velocity.z = direction.z * current_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
		player.velocity.z = move_toward(player.velocity.z, 0, player.speed)

	player.move_and_slide()

func update_camera(delta):
	if player.cameraSpringLength != player._springArm.spring_length:
		player._springArm.spring_length = lerp(player._springArm.spring_length, player.cameraSpringLength, delta * player.cameraZoomSmoothness)

func update_stamina(delta):
	if not player.is_sprinting and player.stamina < player.max_stamina:
		player.stamina += player.stamina_recovery_rate * delta
		player.stamina = clamp(player.stamina, 0, player.max_stamina)
		update_bars()

func process_physics(delta):
	if not player.is_on_floor():
		player.velocity.y -= player.gravity * delta

	if Input.is_action_just_pressed("ui_jump") and player._jumpCounter > 0 and player.stamina >= player.stamina_jump_cost:
		player.velocity.y = player.jumpVelocity
		player._jumpCounter -= 1
		player.stamina -= player.stamina_jump_cost
	var current_speed = player.speed
	if player.is_sprinting and player.stamina > 0:
		current_speed = player.sprint_speed
		player.stamina -= player.stamina_sprint_cost * delta
		player.stamina = clamp(player.stamina, 0, player.max_stamina)
	elif player.is_sneaking:
		current_speed = player.sneak_speed

	update_bars()
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var _cameraPivotY = player.get_node("CameraPivotY")
	var direction = (_cameraPivotY.global_transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()

	if direction:
		player.velocity.x = direction.x * current_speed
		player.velocity.z = direction.z * current_speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
		player.velocity.z = move_toward(player.velocity.z, 0, player.speed)

func use_slot_data(slot_data: SlotData):
	slot_data.item_data.use(player)
	
func get_global_position() -> Vector3:
	return player.global_position
