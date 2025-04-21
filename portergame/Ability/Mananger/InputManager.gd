extends Node

signal interact
signal toggle_inventory
signal start_sprinting
signal stop_sprinting
signal jump_pressed

@export var cameraSpringLength: float = 5.0
@export var mouseSensitivity: float = 0.055
@export var cameraZoomStep: float = 1.0
@export var cameraZoomSmoothness: float = 4.0
@export var cameraMaxZoom: float = 10.0
@export var cameraMinZoom: float = 5.0
@export var lookUpMaxAngle: float = 90.0
@export var lookDownMaxAngle: float = -80.0

var player: Node  # Declare player as a member variable

var _cameraPivotY: Node3D
var _cameraPivotX: Node3D
var _springArm: SpringArm3D
var target_zoom: float

func _ready():
	_cameraPivotY = get_node("/root/Main/Player/CameraPivotY")
	_cameraPivotX = _cameraPivotY.get_node("CameraPivotX")
	_springArm = _cameraPivotX.get_node("SpringArm")
	player = get_node("/root/Main/Player")
	
	_springArm.spring_length = cameraSpringLength
	target_zoom = cameraSpringLength

func _process(delta: float) -> void:
	if cameraSpringLength != _springArm.spring_length:
		_springArm.spring_length = lerpf(_springArm.spring_length, cameraSpringLength, delta * cameraZoomSmoothness)
		
	if Input.is_action_pressed("sneak") and player != null:
		player.is_sneaking = true
	elif player != null:
		player.is_sneaking = false

func _input(event: InputEvent) -> void:
	# Handle camera rotation
	if event is InputEventMouseMotion and Input.is_action_pressed("ui_camera_rotation"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		_cameraPivotY.rotate_y(deg_to_rad(-event.relative.x * mouseSensitivity))
		_cameraPivotX.rotate_x(deg_to_rad(-event.relative.y * mouseSensitivity))
		_cameraPivotX.rotation_degrees.x = clamp(_cameraPivotX.rotation_degrees.x, lookDownMaxAngle, lookUpMaxAngle)

	if Input.is_action_just_released("ui_camera_rotation"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	# Handle zooming
	if Input.is_action_pressed("ui_camera_zoom_up"):
		cameraSpringLength = clampf(cameraSpringLength + cameraZoomStep, cameraMinZoom, cameraMaxZoom)

	if Input.is_action_pressed("ui_camera_zoom_down"):
		cameraSpringLength = clampf(cameraSpringLength - cameraZoomStep, cameraMinZoom, cameraMaxZoom)
	
	if Input.is_action_just_pressed("interact"):
		player.emit_signal("interact")  # Emit the interact signal from the player
	
	if Input.is_action_just_pressed("inventory"):
		player.emit_signal("toggle_inventory")

	if Input.is_action_just_pressed("ui_jump"):
		emit_signal("jump_pressed")

	if Input.is_action_pressed("sprint"):
		emit_signal("start_sprinting")
	elif Input.is_action_just_released("sprint"):
		emit_signal("stop_sprinting")
