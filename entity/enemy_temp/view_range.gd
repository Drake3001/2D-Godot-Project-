extends Area2D

signal player_body_update(code: String, body: CharacterBody2D)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_body_update.emit("PlayerInViewRange", body)

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_body_update.emit("PlayerOutOfViewRange")
