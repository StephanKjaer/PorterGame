extends PanelContainer

@onready var texture_rect = $MarginContainer/SkillGrid/TextureRect
@onready var skill_grid = $MarginContainer/SkillGrid
const SkillSlot = preload("res://Ability/SkillsSystem/SkillSlot.tscn")

# This method sets the skill slot data for a slot.
func set_skill_slot_data(skill_slot_data: SkillSlotData):
	var skill_data = skill_slot_data.skill_data
	texture_rect.texture = skill_data.texture
	
	tooltip_text = "%s\n%s" % [skill_data.name, skill_data.description]

func _ready():
	var ski_data: SkillbookData = load("res://test_skillbook.tres")
	populate_skill_grid(ski_data.skill_slot_datas)

# This method populates the skill grid with skill slot data.
func populate_skill_grid(skill_slot_datas: Array[SkillSlotData]) -> void:
	for child in skill_grid.get_children():
		child.queue_free()
	
	for skill_slot_data in skill_slot_datas:
		var skill_slot = SkillSlot.instantiate()
		skill_grid.add_child(skill_slot)
		
		if skill_slot_data != null:
			skill_slot.set_skill_slot_data(skill_slot_data)
		
