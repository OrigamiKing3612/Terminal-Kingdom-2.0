extends HBoxContainer

@onready var legs_sprite: AnimatedSprite2D = $BoxContainer/LegsSprite

var player_data: PlayerData:
	get: return GameManager.player
var player: Player

var legs_keys: Array[String] = []
var legs_index := 0

var selected_legs_id: String:
	get: return legs_keys[legs_index]
	set(new_value):
		legs_index = legs_keys.find(new_value)
		player_data.legs_id = new_value
		update_legs()

func init() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if player:
		legs_keys = player.legs_options.keys()

		legs_index = legs_keys.find(player_data.legs_id)
		if legs_index == -1:
			legs_index = 0

		update_legs()


func update_legs():
	var legs_id := legs_keys[legs_index]
	player_data.legs_id = legs_id
	legs_sprite.sprite_frames = player.legs_options[legs_id]
	legs_sprite.play("idle_forward")


func _on_legs_left_button_pressed() -> void:
	if legs_keys.size() != 0:
		legs_index = (legs_index - 1) % legs_keys.size()
		update_legs()


func _on_legs_right_button_pressed() -> void:
	if legs_keys.size() != 0:
		legs_index = (legs_index + 1) % legs_keys.size()
		update_legs()
