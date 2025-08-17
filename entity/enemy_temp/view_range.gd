extends Area2D

signal transition(code: String)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		transition.emit("PlayerInViewRange")

func _on_body_exited(body):
	if body.is_in_group("Player"):
		transition.emit("PlayerOutOfViewRange")
