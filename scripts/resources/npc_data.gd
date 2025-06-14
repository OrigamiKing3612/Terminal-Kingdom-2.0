extends Resource
class_name NPCData

@export_group("NPC Settings")
@export var name: String = ""
@export var job: NPCEnums.Job = NPCEnums.Job.None
@export var skill_level: NPCEnums.SkillLevel = NPCEnums.SkillLevel.None
@export var experience: float = 0.0
@export var workplace: Vector3 = Vector3.ZERO
@export var behavior_type: NPCEnums.BehaviorType = NPCEnums.BehaviorType.Idle
@export var age: int = 18 # ?
@export var gender: NPCEnums.Gender = NPCEnums.Gender.Male
@export var hunger: float = 100.0
@export var happiness: float = 100.0
@export var positionToWalkTo: Vector3 = Vector3.ZERO
@export var home: Vector3 = Vector3.ZERO # location of home door (or bed?)

@export_group("Starting NPC Settings")
@export var is_starting_village_npc: bool = false
