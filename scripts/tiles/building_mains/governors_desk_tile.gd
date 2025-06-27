extends BuildingMainTile
class_name GovernorsDeskTile

const GOVERNORS_DESK_SCREEN = preload("res://scenes/ui/screens/GovernorsDesk/GovernorsDeskScreen.tscn")
const NPC_SCENE = preload("res://scenes/npcs/NPC.tscn")

func when_placed():
	var village = Village.new()
	village.init(position)
	GameManager.kingdom.add_village(village)
	village_id = village.id
	village.add_building(self)
	
	var npc = NPC_SCENE.instantiate()
	var data = NPCData.create_new()
	data.skills.clear()
	data.current_job = Utils.Job.Builder
	data.skills[Utils.Job.Builder] = Utils.SkillLevel.Advanced
	data.positionToWalkTo = position + Vector3(0, 0, 4)
	npc.data = data
	npc.position = position + Vector3(40, 0, 40)
	GameManager.kingdom.get_village(village_id).add_npc(npc)
	
	npc.npc_brain.walk_to_position.position = position + Vector3(0, 0, 6)
	npc.npc_brain.current_goal = npc.npc_brain.walk_to_position
	npc.npc_brain.previous_goal = npc.npc_brain.walk_to_position

func _on_interacted() -> void:
	var popup = GOVERNORS_DESK_SCREEN.instantiate()
	SceneManager.show_popup(popup)
	popup.init(village_id)
	popup.position_to_spawn_npcs = position + Vector3(0, 2, 0)
