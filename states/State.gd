extends Node
class_name State

signal transition(state: State, new_state_name: String)
signal set_previous_state

func enter(): 
	pass 
func exit():
	pass 
func handle_event(code: String):
	if code=="TakeDmg": 
		transition.emit(self, "Enemy_hurt")
func return_to_previous(): 
	set_previous_state.emit()  
