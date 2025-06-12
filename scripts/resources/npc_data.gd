extends Resource
class_name NPCData

@export var name: String = ""
@export var is_starting_village_npc: bool = false
@export var job: NPCEnums.JOB = NPCEnums.JOB.NONE
@export var skill_level: NPCEnums.SKILL_LEVEL = NPCEnums.SKILL_LEVEL.NONE
@export var experience: float = 0.0
@export var workplace: Vector3 = Vector3.ZERO
@export var behavior_type: NPCEnums.BEHAVIOR_TYPE = NPCEnums.BEHAVIOR_TYPE.IDLE
@export var hasTalkedToBefore: bool = false
@export var age: int = 18 # ?
@export var gender: NPCEnums.GENDER = NPCEnums.GENDER.MALE
@export var hunger: float = 100.0
@export var happiness: float = 100.0
@export var positionToWalkTo: Vector3 = Vector3.ZERO
@export var home: Vector3 = Vector3.ZERO # location of home door (or bed?)
