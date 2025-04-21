extends Node

var player

func _ready():
	player = get_node("/root/Main/Player")  # Adjust the path to your player node
	player.connect("interact", Callable(self, "_on_interact"))

func _on_interact():
	var interact_ray = get_node("/root/Main/Player/InteractRay")  # Adjust this path to your actual player node path
	if interact_ray and interact_ray.is_colliding():
		var collider = interact_ray.get_collider()
		if collider.has_method("player_interact"):
			collider.player_interact()
		elif collider.has_method("get_item_data"):
			var item_data = collider.get_item_data()
			if item_data:
				emit_signal("add_to_inventory", item_data)
				collider.queue_free()
