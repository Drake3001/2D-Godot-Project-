extends MovementComponentEnemy


var enemy_body= null
var enemy_posx= null
var enemy_posy= null
var state: String= ''
var current_direction :float= 1.0
var speed: float= 10000.0 ###przerzucić do pliku ze stałymi 
var states_dict: Dictionary = {
	"enemy_chase": [basic_chase, [enable_movement]],
	"enemy_attack": [basic_attack, [disable_movement]]
}
signal direction_changed(new_direction)

  
func _ready():
	set_process(false)
	enemy_body=get_parent()
	update_self_position()
	
func update_self_position():
	var tmp= enemy_body.global_position
	enemy_posx=tmp.x
	enemy_posy=tmp.y
	
func handle_new_state(new_state: String):
	state=new_state.to_lower()
	print( state in states_dict)
	if state in states_dict:
		for function in states_dict[state][1]: 
			function.call()
		set_process(true)
	else:
		set_process(false)
		enemy_body.velocity.x=0
		enemy_body.velocity.y=0  
	
func _process(delta: float):
	states_dict[state][0].call(delta)

func basic_chase(delta: float):
	update_self_position()
	if player_body!= null:
		update_direction()
		if movement_enabled: 
			enemy_body.velocity.x = current_direction * speed * delta  
		else:
			enemy_body.velocity.x=0
			
func update_direction(): 
	var player_pos=player_body.global_position
	var direction = sign(player_pos.x - enemy_posx)
	if direction != 0 and direction != current_direction:
		current_direction = direction
		direction_changed.emit(current_direction)

func basic_attack(delta: float):
	if player_body: 
		update_direction()
 
func _physics_process(delta: float) -> void:
	if not enemy_body.is_on_floor(): 
		enemy_body.velocity.y+= 1000 * delta
	enemy_body.move_and_slide()
func disable_movement():
	super()
	enemy_body.velocity.x=0
