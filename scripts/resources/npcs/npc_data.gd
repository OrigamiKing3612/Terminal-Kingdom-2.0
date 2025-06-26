extends Resource
class_name NPCData


var id = UUID.string()

@export_group("NPC Settings")
@export var name: String = ""
@export var last_name: String = ""
@export var current_job: Utils.Job = Utils.Job.None
@export var skills: Dictionary[Utils.Job, Utils.SkillLevel] = {}
@export var experience: float = 0.0
@export var age: int = 18 # ?
@export var gender: Utils.Gender = Utils.Gender.Male
@export var hunger: float = 100.0
@export var happiness: float = 100.0
@export var positionToWalkTo: Vector3 = Vector3.ZERO
@export var home: Vector3 = Vector3.ZERO # location of home door (or bed?)
@export var workplace: Vector3 = Vector3.ZERO # location of work
@export var village_id: String = ""

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
	var has_job: int = GameManager.random.randi_range(0, 1)
	if has_job == 1:
		var job_count: int = GameManager.random.randi_range(1, 3)
		var available_jobs := Utils.Job.keys()
		available_jobs.erase(Utils.Job.King)
		available_jobs.shuffle()

		var skill_levels := ["Apprentice", "Novice", "Advanced", "Expert"]
		if GameManager.random.randf_range(0, 2) == 1:
			skill_levels.append("Master")

		for job_name in available_jobs:
			if data.skills.size() >= job_count:
				break

			var skill_level_name = skill_levels[GameManager.random.randi_range(0, skill_levels.size() - 1)]
			if Utils.Job[job_name] != Utils.Job.King:
				data.skills[Utils.Job[job_name]] = Utils.SkillLevel[skill_level_name]
	
	return data

static func _generate_name(gender: Utils.Gender) -> Dictionary[String, String]:
	var first_name: String
	if gender == Utils.Gender.Male:
		var male_names := [
			"Stanley", "Geophrey", "Cornelius", "Wyatt", "Ben", 
			"Isaac", "Craig", "George", "Nate", "Frank", 
			"James", "Arthur", "Nigel", "John", "Winston", 
			"Curtis", "Julian", "Leo", "Alexander", "Walter", 
			"William", "Kenrick", "Orville", "Harold", "Felix", 
			"Dominic", "Derek", "Damien", "Gideon", "Paul", 
			"Robert", "Edmund", "Charles", "Quinn", "Caleb", 
			"Ulysses", "Simon", "Patrick", "Terrence", "Harry", 
			"Milton", "David", "Tom", "Bob", "Jack", 
			"Chad", "Kieran", "Fred", "Henry", "Edward", 
			"Louis", "Ryan", "Alfred", "Nikolai", "Percy", 
			"Michael", "Kyle", "Mark", "Hugo", "Adam", 
			"Franklin", "Sam", "Percival", "Matt", "Greg", 
			"Peter", "Luke", "Reginald", "Quentin", "Daniel", 
			"Bartholomew", "Malachi", "Zach", "Randolph", "Vernon", 
			"Owen", "Eric", "Liam", "Victor", "Theodore", 
			"Roland", "Xavier", "Irwin", "Marius", "Samuel", 
			"Josh", "Joseph", "Bernard", "Eli", "Leon", 
			"Nathaniel", "Randall", "Ethan", "Jim", "Jimmy", 
			"Oscar", "Clive", "Theo", "Thomas", "Charlie", 
			"Garrett", "Sebastian", "Nathan", "Finn", "Chief",
			"Json", "Jason", "Zachary", "Tyler", "Shepard",
			"Herbert", "Will", "Billy", "Dave", "Leonardo",
			"Alex", "Joe", "Jackson", "Craiggory", "Greggory"
		]
		var index = GameManager.random.randi_range(0, male_names.size() - 1)
		first_name = male_names[index]
	else:
		var female_names := [
			"Jordan", "Beth", "Ava", "Vivian", "Zoey", 
			"Piper", "Sophie", "Esther", "Rosalind", "Iris", 
			"Emily", "Jasmine", "Margret", "Luella", "Florence", 
			"Nellie", "Emma", "Olivia", "Willow", "Rachel", 
			"Victoria", "Petunia", "Beatrice", "Diana", "Julia", 
			"Mary", "Amelia", "Mabel", "Bernice", "Karren", 
			"Wendy", "Edith", "Faith", "Nora", "Evelyn", 
			"Grace", "Judith", "Sylvia", "Maggie", "Lila", 
			"Natalie", "Tara", "Alice", "Fiona", "Tabitha", 
			"Haley", "Sarah", "Hope", "Katherine", "Megan", 
			"Celeste", "Rebecca", "Ellie", "Claire", "Daisy", 
			"Martha", "Taylor", "Dawn", "Anna", "Mia", 
			"Irene", "Isabel", "Katie", "Layla", "Ruth", 
			"Lisa", "Ivy", "Sophia", "Pearl", "Violet", 
			"Kate", "Harper", "Caroline", "Jessica", "Zoe", 
			"Luna", "Paige", "Tessa", "Susanna", "Lily", 
			"Hazel", "Gertrude", "Matilda", "Agnes", "Clara", 
			"Dorothy", "Penelope", "Chloe", "Lucy", "Hannah",
			"Elizabeth", "Tyler"
		]

		var index = GameManager.random.randi_range(0, female_names.size() - 1)
		first_name = female_names[index]
	
	var last_names := [
		"Thompson", "White", "Smith", "Dove", "Prince", 
		"King", "Williams", "Gumbolliak", "Nobell", "Starfin",
		"Jackson", "Martin", "Ellis","Price","Blackwood",
		"Graves", "Dawnsworn", "Duskbane", "Emberly", "Farrow",
		"Greythorn", "Hawke", "Ironhart", "Kingsley", "Locke",
		"Nightshade","Thornfield","Windmere", "Sigma", "Pennyworth",
		"Kingsman", "Blackwell", "Burlow", "Carver", "Chandler", 
		"Driftwood", "Fenwick", "Halloway", "Rookwood", "Wicker", 
		"Smith", "Jones", "Brown", "Snow", "Black", 
		"Green", "Gray", "Stone", "Hill", "Wood", 
		"Page", "Knight", "Reed", "Lane", "Ford", 
		"Cook", "Chase", "Wells", "Shaw", "Hart", 
		"Clark", "Grant", "Cole", "Ray", "West", 
		"Hale", "Pope", "Dale", "Knox", "Cobb",
		"Short", "Bell", "May", "Sharp", "Young",
		"Long", "Blake", "Brooks", "Wade", "Keene",
		"Baird", "Summers", "Firth", "Pike", "Rowe",
		"Sparks", "Go", "Swift", "Portland", "Landery",
		"Abbott", "Baker", "Vance", "Tyler", "York",
		"Boone", "Todd", "Briggs", "Burke", "Tate",
		"Shepard", "Swann", "Crane", "Dunn", "Eaton",
		"Fleming", "Flynn", "Gates", "Goodwin", "Reeves",
		"Perry", "Holt", "Oakes", "Nash", "Marin",
		"Lang", "Mann",
	]
	var index = GameManager.random.randi_range(0, last_names.size() - 1)
	var last_name = last_names[index]
	if GameManager.random.randi_range(1, 100) == 71:
		last_name = "Gumbolliak"
	
	return {"first": first_name, "last": last_name}
