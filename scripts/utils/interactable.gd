extends StaticBody3D

signal interacted

func interact():
	interacted.emit()
