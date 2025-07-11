extends Node



const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var player: CharacterBody2D
var movement_enabled=true
var current_direction=0 

signal move_changed(state)
signal direction_changed(direction)

func _ready(): 
	player=get_parent()
	
	
func handle_move(direction):
	if direction != current_direction:
		current_direction = direction
		direction_changed.emit(direction)

func handle_jump(): 
	if player.is_on_floor():
		player.velocity.y=JUMP_VELOCITY

func update_movement(delta): 
	if not player.is_on_floor(): 
		player.velocity.y+= 1000 * delta
	if movement_enabled:
		player.velocity.x=current_direction*SPEED
	
