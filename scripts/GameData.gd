extends Node

var player := Player.new("DEFAULT_NAME")

class Player:
	var name: String
	var items: Array[Item] = []
	var position := Vector3.ZERO
	var quests: Array[Quest] = []
	var canBuild := true
	#var unlockedDoors: Array[String]
	#var stats := Stats.new()
	
	func _init(name: String):
		name = name
	
	#class Stats:
		#var skill := Skill.new()
		#class Skill:
			#var blacksmithing: SkillProgress
			#var mining: SkillProgress
			#var carpentry: SkillProgress
			#var farming: SkillProgress
			#var building: SkillProgress
			#var sales: SkillProgress
			#var hunting: SkillProgress
			#var inventing: SkillProgress
			#var caretaking: SkillProgress
			#var medicine: SkillProgress
			#var cooking: SkillProgress
		

class Item:
	var type: ItemType
	var canBeSold: bool
	
	func _init(type: ItemType, canBeSold: bool):
		canBeSold = canBeSold
	
enum ItemType{
	sword, axe, pickaxe, boomerang, # bow? net? dagger?
	backpack,
	lumber,
	iron,
	coal,
	gold,
	stone,
	clay,
	tree_seed,
	stick,
	steel,
	door,
	fence,
	gate,
	chest,
	bed,
	desk,
	coin,
	carrot,
	potato,
	wheat,
	lettuce,
	pot,
}
	
enum Quest{
	
}
