extends Resource
class_name NPCBody

@export var hair: Texture2D
@export var eyes: Texture2D
@export var head: Texture2D
@export var torso: Texture2D
@export var legs: Texture2D

@export_group("Starting NPC Settings")
@export var starting_village_body: Texture2D

static func create() -> NPCBody:
	var body = NPCBody.new()
	
	return body
