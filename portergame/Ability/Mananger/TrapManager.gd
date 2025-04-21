extends Node  # Ensure this script is added as an Autoload

const TRAP_SCENE_PATH = "res://Ability/Traps/trap.tscn"

func _on_place_trap():
	var player = get_tree().root.get_node("Main/Player")  # Adjust this path to your actual player node path
	if player:
		place_trap(player)
	else:
		print("Player node not found")

func place_trap(player):
	var trap_scene = load(TRAP_SCENE_PATH)
	if trap_scene and trap_scene is PackedScene:
		var trap_instance = trap_scene.instantiate()
		if trap_instance:
			var node_instance = trap_instance as Node3D
			player.get_parent().add_child(node_instance)
			var player_position = player.global_transform.origin
			var trap_offset = Vector3(0, -0.55, 0)
			var trap_position = player_position + trap_offset
			node_instance.global_transform.origin = trap_position
