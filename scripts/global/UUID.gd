@tool
extends Node

## Returns a new UUID string in the format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
static func string() -> String:
	var hex = "0123456789abcdef"
	var parts = [8, 4, 4, 4, 12]
	var uuid = ""

	for i in parts:
		for j in i:
			uuid += hex[randi() % hex.length()]
		if i != 12:
			uuid += "-"
	return uuid
