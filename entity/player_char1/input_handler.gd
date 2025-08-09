extends Node

signal move_input(direction)
signal jump_pressed 
signal attack_pressed
signal take_dmg

func _input(event): 
	var direction = Input.get_axis("move_left", "move_right")
	move_input.emit(direction)
	
	if Input.is_action_just_pressed("jump"):
		jump_pressed.emit()
	if Input.is_action_just_pressed("attack"):
		attack_pressed.emit(1)
	if Input.is_action_just_pressed("attack2"):
		attack_pressed.emit(2)
	if Input.is_action_just_pressed("debug_take_dmg "):
		take_dmg.emit()
