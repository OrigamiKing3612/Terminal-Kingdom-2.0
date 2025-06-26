extends Node3D
class_name BuildingMainTile

var id: String = UUID.string()
var village_id: String
@export var building_name: String
@export var type: Utils.BuildingType

func when_placed():
	pass
