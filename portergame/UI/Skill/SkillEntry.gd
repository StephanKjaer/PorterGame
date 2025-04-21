extends Control

signal skill_clicked(skill_name: String)
signal skill_hovered(skill_name: String, skill_description: String)

@onready var icon: TextureRect = $MarginContainer/SkillIcon
@onready var name_label: Label = $SkillName

func set_skill(skill):
	if icon != null:
		icon.texture = skill.skill_icon

	if name_label != null:
		name_label.text = skill.skill_name

func _on_mouse_entered():
	emit_signal("skill_hovered", name_label.text, name_label.tooltip_text)

func _on_mouse_exited():
	# Hide tooltip or reset tooltip state as needed
	pass

func _on_pressed():
	emit_signal("skill_clicked", name_label.text)
