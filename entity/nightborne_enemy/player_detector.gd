extends Area2D

signal player_tracking_update 

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_tracking_update.emit(body)

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_tracking_update.emit(null)
