extends CharacterBody3D

@export var data: NPCData

@onready var marker: MeshInstance3D = $Mesh/Marker
@onready var navigation: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	if data != null:
		data = data.duplicate()
	marker.visible = false

func talk() -> void:
	if data.is_starting_village_npc:
		talk_to_starting_village_npc()
		return
	
	print("Talk!")

const TALK_MENU = preload("res://scenes/menus/dialog.tscn")

func talk_to_starting_village_npc():
	var popup = TALK_MENU.instantiate()
	SceneManager.show_popup(popup)
	popup.show_dialog("Text!")
	popup.add_button("Button", button_text)
	SceneManager.free_cursor()
	#popup.popup_centered()

func button_text():
	print("button_text")

func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	marker.visible = true

func _on_body_exited(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	marker.visible = false
	
func _physics_process(delta: float) -> void:
	if marker.visible:
		look_at(GameData.player.position, Vector3.UP)
