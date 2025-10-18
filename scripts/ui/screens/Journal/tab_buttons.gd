extends Control

@onready var journal_screen: JournalScreen = $".."

var selected_tab: JournalScreen.JournalTabs:
	get: return journal_screen.selected_tab_index

func _on_back_tab_pressed() -> void:
	if selected_tab == JournalScreen.JournalTabs.info:
		return
	journal_screen.selected_tab_index -= 1

func _on_next_tab_pressed() -> void:
	if selected_tab == JournalScreen.JournalTabs.six:
		return
	journal_screen.selected_tab_index += 1
