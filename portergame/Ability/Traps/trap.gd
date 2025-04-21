extends StaticBody3D

@export var damage_amount: int = 10  # Amount of damage dealt to enemies

func _ready():
	var area = get_node("Area3D")
	if area:
		area.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemies"):  # Ensure your enemy nodes are in the "enemies" group
		if body.has_method("take_damage"):
			body.call("take_damage", damage_amount)
			print("Trap triggered!")
			queue_free()  # Destroy the trap after it triggers once (optional)
		else:
			print("Body does not have take_damage method")
