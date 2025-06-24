extends Resource
class_name NPCData


var id = UUID.string()

@export_group("NPC Settings")
@export var name: String = ""
@export var last_name: String = ""
@export var job: Utils.Job = Utils.Job.None
@export var skill_level: Utils.SkillLevel = Utils.SkillLevel.None
@export var experience: float = 0.0
#@export var behavior_type: Utils.BehaviorType = Utils.BehaviorType.Idle
@export var age: int = 18 # ?
@export var gender: Utils.Gender = Utils.Gender.Male
@export var hunger: float = 100.0
@export var happiness: float = 100.0
@export var positionToWalkTo: Vector3 = Vector3.ZERO
@export var home: Vector3 = Vector3.ZERO # location of home door (or bed?)
@export var workplace: Vector3 = Vector3.ZERO # location of work

@export_group("Starting NPC Settings")
@export var is_starting_village_npc: bool = false

static func create_new() -> NPCData:
	var data := NPCData.new()
	var gender = Utils.Gender.Male if GameManager.random.randi_range(0,1) == 0 else Utils.Gender.Female
	var name := _generate_name(gender)
	data.name = name["first"]
	data.last_name = name["last"]
	data.age = GameManager.random.randi_range(18, 60)
	data.gender = gender
	data.is_starting_village_npc = false
	
	return data

static func _generate_name(gender: Utils.Gender) -> Dictionary[String, String]:
	var first_name: String
	if gender == Utils.Gender.Male:
		var male_names := [
			"Alexander", "Fred", "Geophrey", "Haymitch", "Louis", 
			"Craig", "Harry", "Garrett", "Jack", "Eli", 
			"Isaac", "Charles", "Charlie", "Dominic", "Hugo", 
			"John", "Adam", "Ryan", "Mark", "Samuel", 
			"Jim", "Nathaniel", "Cornelius", "William", "James", 
			"Ethan", "Patrick", "Peter", "Josh", "Quinn", 
			"Luke", "Jimmy", "Xavier", "Bartholomew", "Chad"
		]
		var index = GameManager.random.randi_range(0, male_names.size())
		first_name = male_names[index]
	else:
		var female_names := [
			"Luna", "Luella", "Hope", "Hannah", "Caroline", 
			"Alice", "Lily", "Petunia", "Taylor", "Jessica", 
			"Lucy", "Willow", "Susanna", "Sarah", "Dawn",
			"Mary", "Anna", "Karren", "Zoe"
		]
		var index = GameManager.random.randi_range(0, female_names.size())
		first_name = female_names[index]
	
	var last_names := [
		"Thompson", "White", "Smith", "Dove", "Prince", 
		"King", "Williams", "Gumbolliak", "Nobell", "Starfin",
		"Jackson", "Martin", "Ellis"
	]
	var index = GameManager.random.randi_range(0, last_names.size())
	var last_name = last_names[index]
	
	return {"first": first_name, "last": last_name}
