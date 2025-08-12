extends Node
class_name State

signal transition(state: State, new_state_name: String)

func enter(): 
	pass 
func exit():
	pass 
func update(delta: float) -> void:
	pass 
