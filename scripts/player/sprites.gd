extends Node2D

@onready var player: Player = $".."

@onready var hair: AnimatedSprite2D = $Hair
@onready var head: AnimatedSprite2D = $Head
@onready var legs: AnimatedSprite2D = $Legs
@onready var torso: AnimatedSprite2D = $Torso
@onready var eyes: AnimatedSprite2D = $Eyes

func _ready() -> void:
	GameManager.player.body_changed.connect(_on_body_changed)
	_on_body_changed()

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
	
	if animation_name.contains("forward"):
		eyes.play("blink_forward")
		eyes.show()
	elif animation_name.contains("left"):
		eyes.play("blink_left")
		eyes.show()
	elif animation_name.contains("right"):
		eyes.play("blink_right")
		eyes.show()
	elif animation_name.contains("back"):
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
	
func _on_body_changed():
	hair.sprite_frames = player.hair_options[GameManager.player.hair_id]
	eyes.sprite_frames = player.eyes_options[GameManager.player.eyes_id]
	head.sprite_frames = player.head_options[GameManager.player.head_id]
	torso.sprite_frames = player.torso_options[GameManager.player.torso_id]
	legs.sprite_frames = player.legs_options[GameManager.player.legs_id]
