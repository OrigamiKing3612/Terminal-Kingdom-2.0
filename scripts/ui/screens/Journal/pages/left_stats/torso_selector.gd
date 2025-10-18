extends HBoxContainer

@onready var torso_sprite: AnimatedSprite2D = $BoxContainer/TorsoSprite

var player_data: PlayerData:
	get: return GameManager.player
var player: Player

var torso_keys: Array[String] = []
var torso_index := 0

var selected_torso_id: String:
	get: return torso_keys[torso_index]
	set(new_value):
		torso_index = torso_keys.find(new_value)
		player_data.torso_id = new_value
		update_torso()

func init() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if player:
		torso_keys = player.torso_options.keys()

		torso_index = torso_keys.find(player_data.torso_id)
		if torso_index == -1:
			torso_index = 0

		update_torso()


func update_torso():
	var torso_id := torso_keys[torso_index]
	player_data.torso_id = torso_id
	torso_sprite.sprite_frames = player.torso_options[torso_id]
	torso_sprite.play("idle_forward")


func _on_torso_left_button_pressed() -> void:
	if torso_keys.size() != 0:
		torso_index = (torso_index - 1) % torso_keys.size()
		update_torso()


func _on_torso_right_button_pressed() -> void:
	if torso_keys.size() != 0:
		torso_index = (torso_index + 1) % torso_keys.size()
		update_torso()
