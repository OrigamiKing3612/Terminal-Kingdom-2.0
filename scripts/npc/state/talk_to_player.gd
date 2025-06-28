extends NPCState

var player: CharacterBody2D

func enter() -> void:
	super()
	character.velocity.x = 0
	character.velocity.y = 0
	player = get_tree().get_first_node_in_group("Player")

func exit() -> void:
	pass

func process_input(event: InputEvent) -> NPCState:
	return null
	
func physics_process(delta: float) -> void:
	#character.velocity.y += -gravity * delta
	character.move_and_slide()
	
	if player:
		character.look_at(Vector2(player.global_position.x, player.global_position.y))
