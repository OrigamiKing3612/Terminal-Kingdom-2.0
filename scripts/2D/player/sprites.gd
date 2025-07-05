extends Node2D

@onready var hair: AnimatedSprite2D = $Hair
@onready var head: AnimatedSprite2D = $Head
@onready var legs: AnimatedSprite2D = $Legs
@onready var torso: AnimatedSprite2D = $Torso
@onready var eyes: AnimatedSprite2D = $Eyes

func play_all(animation_name: String) -> void:
	if hair.sprite_frames.has_animation(animation_name):
		hair.show()
		hair.play(animation_name)
	else:
		hair.stop()
		hair.hide()
	if head.sprite_frames.has_animation(animation_name):
		head.show()
		head.play(animation_name)
	else:
		head.stop()
		head.hide()
	if legs.sprite_frames.has_animation(animation_name):
		legs.show()
		legs.play(animation_name)
	else:
		legs.stop()
		legs.hide()
	if torso.sprite_frames.has_animation(animation_name):
		torso.show()
		torso.play(animation_name)
	else:
		torso.stop()
		torso.hide()
	if eyes.sprite_frames.has_animation(animation_name):
		eyes.show()
		eyes.play(animation_name)
	else:
		eyes.stop()
		eyes.hide()

func stop_all() -> void:
	hair.stop()
	head.stop()
	legs.stop()
	torso.stop()
	eyes.stop()

func is_playing() -> bool:
	return hair.is_playing() and head.is_playing() and legs.is_playing() and torso.is_playing() and eyes.is_playing()

func speed_scale(speed: int) -> void:
	hair.speed_scale = speed
	head.speed_scale = speed
	legs.speed_scale = speed
	torso.speed_scale = speed
	eyes.speed_scale = speed
