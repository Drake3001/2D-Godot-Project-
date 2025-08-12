extends Node
class_name StateMachineEnemy 


var current_state: State = null


var states: Dictionary={}
func _ready():
	for child in get_children(): 
		if child is State: 
			states[child.name.to_lower()]=child 
			child.transition.connect(on_child_transitioned)
	current_state= states["enemy_idle"]
	if current_state:
		current_state.enter()
func _process(delta: float)-> void:
	if current_state:
		current_state.update(delta)

func on_child_transitioned(state, new_state_name)-> void :
	print("siems")
	if state!= current_state: 
		return
	var new_state= states[new_state_name.to_lower()]
	if !new_state: 
		return
	if current_state: 
		current_state.exit()
	new_state.enter()
	current_state=new_state 
