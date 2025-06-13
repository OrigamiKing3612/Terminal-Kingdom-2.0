extends CanvasLayer

@onready var hot_bar: HotBar = $HotBar

func _on_show_building() -> void:
	hot_bar.items = GameManager.player.items
	hot_bar.show_hot_bar()

func _on_hide_building() -> void:
	hot_bar.hide_hot_bar()
