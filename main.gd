extends Node

@onready var player = $Player
@onready var inventory_interface:Control = $UI/InventoryInterface

func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)

func toggle_inventory_interface() -> void:
	inventory_interface.visible = not inventory_interface.visible
	
	
	print ("https://www.youtube.com/watch?v=V79YabQZC1s&t=374s 39:23")
