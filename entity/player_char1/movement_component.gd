extends Node


const Const = preload("res://entity/player_char1/const_player.gd")

var SPEED = Const.SPEED
const JUMP_VELOCITY = Const.JUMP_VELOCITY
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
	if player.is_on_floor() and movement_enabled:
		player.velocity.y=JUMP_VELOCITY
		return true
	return false 

func update_movement(delta): 
	if not player.is_on_floor(): 
		player.velocity.y+= 1000 * delta
	if movement_enabled:
		player.velocity.x=current_direction*SPEED
		
func swap_move_speed(new_ms):
	SPEED=new_ms  
func disable_movement(): 
	player.velocity.x=0
	movement_enabled=false 
func enable_movement(): 
	movement_enabled=true
	
