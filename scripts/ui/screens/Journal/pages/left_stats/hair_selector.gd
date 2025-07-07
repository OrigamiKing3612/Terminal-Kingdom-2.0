extends HBoxContainer

@onready var hair_sprite: AnimatedSprite2D = $BoxContainer/HairSprite

var player_data: PlayerData:
	get: return GameManager.player
var player: Player

var hair_keys: Array[String] = []
var hair_index := 0

var selected_hair_id: String:
	get: return hair_keys[hair_index]
	set(new_value):
		hair_index = hair_keys.find(new_value)
		player_data.hair_id = new_value
		update_hair()

func init() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if player:
		hair_keys = player.hair_options.keys()

		hair_index = hair_keys.find(player_data.hair_id)
		if hair_index == -1:
			hair_index = 0

		update_hair()


func update_hair():
	var hair_id := hair_keys[hair_index]
	player_data.hair_id = hair_id
	hair_sprite.sprite_frames = player.hair_options[hair_id]
	hair_sprite.play("idle_forward")


func _on_hair_left_button_pressed() -> void:
	if hair_keys.size() != 0:
		hair_index = (hair_index - 1) % hair_keys.size()
		update_hair()


func _on_hair_right_button_pressed() -> void:
	if hair_keys.size() != 0:
		hair_index = (hair_index + 1) % hair_keys.size()
		update_hair()
