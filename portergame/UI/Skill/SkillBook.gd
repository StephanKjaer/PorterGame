extends Control

@onready var skill_container: GridContainer = $MarginContainer/SkillGrid
var skill_entries = []

func _ready():
	# Initialize or set up anything here if needed
	pass

func update_skill_book(skills: Array):
	# Clear existing entries
	while skill_container.get_child_count() > 0:
		var child = skill_container.get_child(0)
		skill_container.remove_child(child)
		child.queue_free()  # Free the child to prevent memory leaks

	# Load the SkillEntry scene
	var SkillEntryScene = preload("res://UI/Skill/SkillEntry.tscn")

	# Add new skill entries
	for skill_data in skills:
		var skill_entry = SkillEntryScene.instantiate()
		skill_entry.set_skill(skill_data)  # Call set_skill method to set skill data

		# Connect to skill_hovered signal using Callable
		

		skill_container.add_child(skill_entry)
		skill_entries.append(skill_entry)

func _on_skill_hovered(skill_name, skill_description):
	# Handle skill hover event
	print("Hovered over skill:", skill_name)
	print("Description:", skill_description)
	# Update UI elements or perform other actions here
