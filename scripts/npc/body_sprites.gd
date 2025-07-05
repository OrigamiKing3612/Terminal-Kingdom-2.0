extends Node2D

@onready var hair: Sprite2D = $Hair
@onready var head: Sprite2D = $Head
@onready var eyes: Sprite2D = $Eyes
@onready var torso: Sprite2D = $Torso
@onready var legs: Sprite2D = $Legs

func set_images(body: NPCBody) -> void:
	if body.hair: hair.texture = body.hair
	if body.head: head.texture = body.head
	if body.eyes: eyes.texture = body.eyes
	if body.torso: torso.texture = body.torso
	if body.legs: legs.texture = body.legs
