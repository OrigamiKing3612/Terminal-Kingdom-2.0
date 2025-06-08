extends Area3D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
