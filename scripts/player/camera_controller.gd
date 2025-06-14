extends Node3D

signal set_camera_rotation(_camera_rotation: float)
@export var player : CharacterBody3D
@onready var camera_yaw: Node3D = $CameraYawH
@onready var camera_pitch: Node3D = $CameraYawH/CameraPitchV
@onready var camera: Camera3D = $CameraYawH/CameraPitchV/SpringArm3D/Camera3D

var yaw: float = 0
var pitch: float = 0
var yaw_sensitivity: float = 0.07
var pitch_sensitivity: float = 0.07
var yaw_acceleration: float = 15
var pitch_acceleration: float = 15
var pitch_max: float = 360
var pitch_min: float = -360
#var tween: Tween
var position_offset: Vector3 = Vector3(0, 1.3, 0)
var position_offset_target: Vector3 = Vector3(0, 1.3, 0)

func _ready() -> void:
	SceneManager.steal_cursor()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and GameManager.move:
		yaw += -event.relative.x * yaw_sensitivity
		pitch += event.relative.y * pitch_sensitivity

func _physics_process(delta: float) -> void:
	pitch = clamp(pitch, pitch_min, pitch_max)
	
	camera_yaw.rotation_degrees.y = lerp(camera_yaw.rotation_degrees.y, yaw, yaw_acceleration * delta)
	camera_pitch.rotation_degrees.x = -lerp(camera_pitch.rotation_degrees.x, pitch, pitch_acceleration * delta)
	
	#camera_yaw.rotation_degrees.y = yaw
	#camera_pitch.rotation_degrees.x = pitch
	
	set_camera_rotation.emit(camera_yaw.rotation.y)

func _on_set_movement_state(_movement_state: MovementState):
	#if tween:
		#tween.kill()
	#
	#tween = create_tween()
	#tween.tween_property(camera, "fov", _movement_state.camera_fov, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	pass


#func _on_set_stance(_stance : Stance):
	#position_offset_target.y = _stance.camera_height
	
