extends Resource
class_name NPCData

@export var name: String = ""
@export var is_starting_village_npc: bool = false
@export var job: NPC_JOB = NPC_JOB.NONE
@export var skill_level: SKILL_LEVEL = SKILL_LEVEL.NONE
@export var experience: float = 0.0
@export var workplace: Vector3 = Vector3.ZERO
@export var behavior_type: BEHAVIOR_TYPE = BEHAVIOR_TYPE.IDLE
@export var hasTalkedToBefore: bool = false
@export var age: int = 18 # ?
@export var gender: GENDER = GENDER.MALE
@export var hunger: float = 100.0
@export var happiness: float = 100.0
@export var positionToWalkTo: Vector3 = Vector3.ZERO
@export var home: Vector3 = Vector3.ZERO # location of home door (or bed?)

enum NPC_JOB{NONE, BLACKSMITH, KING, MINER, FARMER, DOCTER, SALESMAN, POTTER, STABLEMASTER, CARPENTER, BUILDER, HUNTER, INVENTOR, CHEF}
enum SKILL_LEVEL{NONE, NOVICE, APPRENTICE, JOURNEYMAN, EXPERT, MASTER}
enum BEHAVIOR_TYPE{IDLE, WANDER, STAND, WORK}
enum GENDER{MALE,FEMALE}
