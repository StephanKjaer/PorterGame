extends Node

var inventory = [] # Array to hold items (dictionaries of {"item": ItemData, "quantity": int})

func add_item(item_resource: ItemData, quantity: int = 1):
	for item in inventory:
		if item.item == item_resource and item_resource.is_stackable:
			item.quantity += quantity
			return
	inventory.append({"item": item_resource, "quantity": quantity})
	print("Added " + str(quantity) + " of " + item_resource.item_name + " to inventory.") # Optional feedback
	# Later, we'll need to update the UI here
	
func remove_item(item_resource: ItemData, quantity: int = 1):
	for i in range(inventory.size() - 1, -1, -1): # Iterate backwards for safe removal
		if inventory[i].item == item_resource:
			inventory[i].quantity -= quantity
			if inventory[i].quantity <= 0:
				inventory.remove_at(i)
				print("Removed all of " + item_resource.item_name + " from inventory.") # Optional feedback
			else:
				print("Removed " + str(quantity) + " of " + item_resource.item_name + " from inventory. Remaining: " + str(inventory[i].quantity)) # Optional feedback
			# Later, we'll need to update the UI here
			return
	print("Item " + item_resource.item_name + " not found in inventory.") # Optional feedback

