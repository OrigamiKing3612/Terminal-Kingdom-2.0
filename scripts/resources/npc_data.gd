extends Resource
class_name NPCData

var id = UUID.string()

@export_group("NPC Settings")
@export var name: String = ""
@export var job: Utils.Job = Utils.Job.None
@export var skill_level: Utils.SkillLevel = Utils.SkillLevel.None
@export var experience: float = 0.0
@export var workplace: Vector3 = Vector3.ZERO
@export var behavior_type: Utils.BehaviorType = Utils.BehaviorType.Idle
@export var age: int = 18 # ?
@export var gender: Utils.Gender = Utils.Gender.Male
@export var hunger: float = 100.0
@export var happiness: float = 100.0
@export var positionToWalkTo: Vector3 = Vector3.ZERO
@export var home: Vector3 = Vector3.ZERO # location of home door (or bed?)

@export_group("Starting NPC Settings")
@export var is_starting_village_npc: bool = false
