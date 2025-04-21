extends PanelContainer

@onready var texture_rect = $MarginContainer/TextureRect

# This method sets the skill slot data for a slot.
func set_skill_slot_data(skill_slot_data: SkillSlotData):
	if skill_slot_data == null:
		print("SkillSlotData is null")
		return

	var skill_data = skill_slot_data.skill_data

	if skill_data == null:
		print("SkillData is null")
		return
	
	texture_rect.texture = skill_data.texture
	tooltip_text = "%s\n%s" % [skill_data.name, skill_data.description]
