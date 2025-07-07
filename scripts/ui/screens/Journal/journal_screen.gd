extends Control
class_name JournalScreen

signal changed

enum JournalTabs{info,quests,blueprints,stats,four,five,six}

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

## Set to zero by default so its always the first tab in the enum that is selected when opened
@export var selected_tab_index: JournalTabs = 0:
	set(new_value):
		selected_tab_index = new_value
		animated_sprite.play(_tab_to_animation(selected_tab_index))
		changed.emit()

func _tab_to_animation(tab: JournalTabs) -> String:
	match selected_tab_index:
		JournalTabs.info: return "0_open"
		JournalTabs.quests: return "1_quests"
		JournalTabs.blueprints: return "2_blueprints"
		JournalTabs.stats: return "3_stats"
		JournalTabs.four: return "4"
		JournalTabs.five: return "5"
		JournalTabs.six: return "6"
	return "unknown"
