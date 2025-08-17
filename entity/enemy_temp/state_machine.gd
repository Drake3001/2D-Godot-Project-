extends Node
class_name StateMachineEnemy

signal state_changed(new_state: String)

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
		state_changed.emit("enemy_idle")

func on_child_transitioned(state, new_state_name)-> void :
	if state!= current_state: 
		return
	var new_state= states[new_state_name.to_lower()]
	if !new_state: 
		return
	if current_state: 
		current_state.exit()
		state_changed.emit(new_state_name)
	new_state.enter()
	current_state=new_state
	
func handle_event(code: String):
	current_state.handle_event(code)
