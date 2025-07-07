extends Node

@onready var journal_screen: JournalScreen = $".."

@onready var left_info: VBoxContainer = $"../LeftSide/LeftInfo"
@onready var right_info: VBoxContainer = $"../RightSide/RightInfo"

@onready var left_quests: VBoxContainer = $"../LeftSide/LeftQuests"
@onready var right_quests: VBoxContainer = $"../RightSide/RightQuests"

@onready var left_blueprints: VBoxContainer = $"../LeftSide/LeftBlueprints"
@onready var right_blueprints: VBoxContainer = $"../RightSide/RightBlueprints"

@onready var left_stats: VBoxContainer = $"../LeftSide/LeftStats"
@onready var right_stats: VBoxContainer = $"../RightSide/RightStats"


func _ready() -> void:
	right_info.get_node("PlayerName").text = GameManager.player.name

func _on_journal_screen_changed() -> void:
	hide_all()
	match journal_screen.selected_tab_index:
		JournalScreen.JournalTabs.info:
			left_info.show()
			right_info.show()
		JournalScreen.JournalTabs.quests:
			left_quests.show()
			right_quests.show()
		JournalScreen.JournalTabs.blueprints:
			left_blueprints.show()
			right_blueprints.show()
		JournalScreen.JournalTabs.stats:
			left_stats.show()
			right_stats.show()
		JournalScreen.JournalTabs.four:
			pass
		JournalScreen.JournalTabs.five:
			pass
		JournalScreen.JournalTabs.six:
			pass

func hide_all() -> void:
	left_info.hide()
	right_info.hide()
	
	left_quests.show()
	right_quests.show()
	
	left_blueprints.hide()
	right_blueprints.hide()
	
	left_stats.hide()
	right_stats.hide()
