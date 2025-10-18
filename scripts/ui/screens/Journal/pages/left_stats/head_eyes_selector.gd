extends HBoxContainer

@onready var head_sprite: AnimatedSprite2D = $BoxContainer/HeadSprite

var player_data: PlayerData:
	get: return GameManager.player
var player: Player

var head_keys: Array[String] = []
var head_index := 0

var selected_head_id: String:
	get: return head_keys[head_index]
	set(new_value):
		head_index = head_keys.find(new_value)
		player_data.head_id = new_value
		update_head()

func init() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if player:
		head_keys = player.head_options.keys()

		head_index = head_keys.find(player_data.head_id)
		if head_index == -1:
			head_index = 0

		update_head()


func update_head():
	var head_id := head_keys[head_index]
	player_data.head_id = head_id
	head_sprite.sprite_frames = player.head_options[head_id]
	head_sprite.play("idle_forward")


func _on_head_left_button_pressed() -> void:
	if head_keys.size() != 0:
		head_index = (head_index - 1) % head_keys.size()
		update_head()


func _on_head_right_button_pressed() -> void:
	if head_keys.size() != 0:
		head_index = (head_index + 1) % head_keys.size()
		update_head()
