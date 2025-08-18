extends Node
class_name MovementComponentEnemy

var movement_enabled: bool =true
var player_body= null  
	
func _ready():
	pass
func enable_movement(): 
	movement_enabled=true
func disable_movement(): 
	movement_enabled=false
func update_player_body(body): 
	player_body= body
func _process(delta: float): 
	pass
func handle_new_state(state_name: String):
	pass 
