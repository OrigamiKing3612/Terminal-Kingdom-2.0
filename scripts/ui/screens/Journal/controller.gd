extends Node

@onready var journal_screen: JournalScreen = $".."

@onready var left_info: VBoxContainer = $"../LeftSide/LeftInfo"
@onready var right_info: VBoxContainer = $"../RightSide/RightInfo"

@onready var left_quests: VBoxContainer = $"../LeftSide/LeftQuests"
@onready var right_quests: VBoxContainer = $"../RightSide/RightQuests"

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
			pass
		JournalScreen.JournalTabs.stats:
			pass
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
