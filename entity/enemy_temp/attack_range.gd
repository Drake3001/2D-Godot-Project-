extends Area2D

signal player_body_update(code: String)

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_body_update.emit("PlayerOutOfAttackRange")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_body_update.emit("PlayerInAttackRange")
