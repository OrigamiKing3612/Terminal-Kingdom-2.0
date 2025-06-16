extends Node

func string() -> String:
	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
	var uuid := ""
	for i in range(16):
		uuid += chars[randi() % chars.length()]
	return uuid
