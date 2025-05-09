extends Resource
class_name SlotData

const Max_Stack_Size: int = 99 

@export var item_data: ItemData
@export_range(1, Max_Stack_Size) var quantity: int = 1: set = set_quantity 

func can_marge_with(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data \
			and item_data.stackable \
			and quantity < Max_Stack_Size


func can_fully_marge_with(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data \
			and item_data.stackable \
			and quantity + other_slot_data.quantity <= Max_Stack_Size
			

func fully_marge_with(other_slot_data: SlotData):
	quantity += other_slot_data.quantity
	
			
func create_single_slot_data() -> SlotData:
	var new_slot_data = duplicate()
	new_slot_data.quantity = 1
	quantity -= 1
	return new_slot_data



func set_quantity(value:int) -> void:
	quantity = value
	if quantity > 1 and not item_data.stackable:
		quantity = 1
		push_error("%s is not stackalbe, setting quantity to 1" % item_data.name)

