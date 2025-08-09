extends Area2D

signal hit_taken(dmg)

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("ENM_ATTACK"):
		hit_taken.emit(1) # tu 1 to dmg
