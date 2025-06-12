extends Node

var player := Player.new("DEFAULT_NAME")
var flags: Array[String] = []

class Player:
	var name: String
	var items: Array[Item] = []
	var position := Vector3.ZERO
	var quests: Array[Quest] = []
	var canBuild := true
	var skill: Skill = Skill.new()
	#var unlockedDoors: Array[String]
	#var stats := Stats.new()
	
	func _init(name: String):
		self.name = name
	
	class Skill:
		var blacksmithing := SkillProgress.new()
		var mining := SkillProgress.new()
		var carpentry := SkillProgress.new()
		var farming := SkillProgress.new()
		var building := SkillProgress.new()
		var sales := SkillProgress.new()
		var hunting := SkillProgress.new()
		var inventing := SkillProgress.new()
		var caretaking := SkillProgress.new()
		var medicine := SkillProgress.new()
		var cooking := SkillProgress.new()
			
	#class Stats:
		#var skill := Skill.new()

class SkillProgress:
	var stage := 0
	var level := NPCEnums.SKILL_LEVEL.NONE

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
