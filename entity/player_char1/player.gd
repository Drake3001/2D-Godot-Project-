extends CharacterBody2D

const Const = preload("res://entity/player_char1/const_player.gd")


@onready var animation_player=  $AnimatedSprite2D
@onready var movement_component = $MovementComponent
@onready var input_handler= $InputHandler
@onready var combat_handler= $CombatHandler
@onready var hitbox_manager= $HitHurtBoxManager


var current_state= Const.State.IDLE
var previous_state= Const.State.IDLE
var jump_pressed = false
var attack_pressed = false
var is_attacking=false
var facing_direction= 0
var turned=1 
var taking_dmg=false 

func _ready():
	$Hurtbox.connect("hit_taken", Callable(self, "take_dmg")) 
	input_handler.jump_pressed.connect(on_jump)
	input_handler.move_input.connect(movement_component.handle_move)
	input_handler.move_input.connect(on_move_input)
	input_handler.attack_pressed.connect(on_attack)
	animation_player.animation_complete.connect(on_animation_finished)
	animation_player.end_invull.connect(hitbox_manager.enable_hurtbox)
	##DEBUG 
	input_handler.take_dmg.connect(take_dmg)


func on_jump(): 
	if is_on_floor():
		movement_component.handle_jump() 
		change_state(Const.State.JUMP)

func on_move_input(direction):
	if current_state==Const.State.ATTACK or current_state==Const.State.ATTACK2:
		return 
	if direction!= facing_direction:
		facing_direction = direction
		if direction!=0:
			turned=direction
			animation_player.update_direction(direction)

func on_attack(id):
	if is_attacking==true: 
		return
	else: 
		is_attacking = true
		movement_component.swap_move_speed(Const.ATTACKING_MS)
		if id == 1:
			change_state(Const.State.ATTACK)
		elif id == 2:
			change_state(Const.State.ATTACK2)
		hitbox_manager.set_hitboxes_for_attack(id, turned)
		
func _physics_process(delta):
	#print_state()
	update_state()
	movement_component.update_movement(delta)
	move_and_slide()
	
func change_state(new_state):
	if new_state != current_state:
		previous_state = current_state
		current_state = new_state
		animation_player.play_animation(current_state)
		
func update_state():
	if current_state==Const.State.DEAD:
		return
	if current_state==Const.State.TAKING_DMG:
		return
	if is_attacking:
		if current_state != Const.State.ATTACK and current_state != Const.State.ATTACK2:
			call_deferred("reset_attacking")
		return
		
	
	if not is_on_floor(): 
		if velocity.y>0: 
			change_state(Const.State.FALLING)
		else:
			change_state(Const.State.JUMP)
		return 
		
	
		
	if abs(facing_direction) > 0:
		change_state(Const.State.RUNNING)
	else:
		change_state(Const.State.IDLE)
		
		
func print_state(): 
	match current_state: 
		Const.State.IDLE: print("idle")
		Const.State.ATTACK: print("attack")
		Const.State.ATTACK2: print("attack2")
		Const.State.JUMP: print("jump")
		Const.State.FALLING: print("falling")
		Const.State.RUNNING: print("walk")
		Const.State.TAKING_DMG: print("taking_ dmg")

func on_animation_finished():
	if current_state == Const.State.ATTACK or current_state == Const.State.ATTACK2:
		#is_attacking = false
		call_deferred("reset_attacking")
	if current_state == Const.State.TAKING_DMG:
		print("Włączam movement i wychodzę z taking dmg")
		taking_dmg=false  
		movement_component.enable_movement()
		change_state(Const.State.IDLE)
	
func reset_attacking():
	is_attacking = false
	movement_component.swap_move_speed(Const.SPEED)
	
func take_dmg():
	if taking_dmg: 
		return
	taking_dmg=true
	hitbox_manager.disable_hurtbox()
	movement_component.disable_movement()
	change_state(Const.State.TAKING_DMG)
	
	
