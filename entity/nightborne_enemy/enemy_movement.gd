extends Node

const Const = preload("res://entity/nightborne_enemy/const_nighborne.gd")


signal direction_changed 
var current_direction= 1.0
var enemy=null
var movememnt_enabled= true

func _ready(): 
	enemy=get_parent()


func update_movement(player_x_axis: float, enemy_position: float):
	var direction = sign(player_x_axis - enemy_position)
	
	if direction != 0 and direction != current_direction:
		current_direction = direction
		direction_changed.emit(current_direction)
	if movememnt_enabled: 
		enemy.velocity.x = direction * Const.SPEED
	else:
		enemy.velocity.x=0 
		
	
func disable_movement():
	movememnt_enabled=false
func enable_movement(): 
	movememnt_enabled=true 
