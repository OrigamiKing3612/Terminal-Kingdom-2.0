extends VBoxContainer

@onready var _no_village_label: HBoxContainer = $HBoxContainer/VBoxContainer/NoVillageLabel
@onready var number_of_npcs: HBoxContainer = $HBoxContainer/VBoxContainer/NumberOfNPCs

var village: Village

func init() -> void:
	var villages = GameManager.kingdom.find_nearby_villages(GameManager.player.position)
	if not villages.size() > 0:
		hide_all()
		village = null
		_no_village_label.show()
		return
	village = villages[0]
	if not village: return
	number_of_npcs.get_node("TitleLabel").text = village.get_npcs().size()

func hide_all():
	number_of_npcs.hide()
