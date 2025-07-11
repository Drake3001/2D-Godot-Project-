extends CharacterBody2D
enum State{
	IDLE, 
	RUNNING, 
	ATTACK,
	ATTACK2, 
	JUMP,
	FALLING, 
	DEAD
}
enum Direction{LEFT=-1, 
RIGHT=1 }

@onready var animation_player=  $AnimatedSprite2D
@onready var movement_component = $MovementComponent
@onready var input_handler= $InputHandler
@onready var combat_handler= $CombatHandler


var current_state= State.IDLE
var previous_state= State.IDLE
var jump_pressed = false
var attack_pressed = false
var is_attacking=false
var facing_direction= 0

func _ready(): 
	#enter_state(State.IDLE)
	input_handler.jump_pressed.connect(on_jump)
	input_handler.move_input.connect(movement_component.handle_move)
	input_handler.move_input.connect(on_move_input)
	input_handler.attack_pressed.connect(on_attack)
	animation_player.animation_complete.connect(on_animation_finished)



func on_jump(): 
	if is_on_floor():
		movement_component.handle_jump() 
		change_state(State.JUMP)

func on_move_input(direction):
	if direction!= facing_direction:
		facing_direction = direction
		if direction!=0:
			animation_player.update_direction(direction)

func on_attack(id):
	if is_attacking==true: 
		return
	else: 
		is_attacking = true
		if id == 1:
			change_state(State.ATTACK)
		elif id == 2:
			change_state(State.ATTACK2)

func _physics_process(delta):
	update_state()
	movement_component.update_movement(delta)
	move_and_slide()
	
func change_state(new_state):
	if new_state != current_state:
		previous_state = current_state
		current_state = new_state
		animation_player.play_animation(current_state)
		
func update_state():
	if current_state==State.DEAD:
		return
	
	if is_attacking:
		if current_state != State.ATTACK and current_state != State.ATTACK2:
			call_deferred("reset_attacking")
		return
		
	
	if not is_on_floor(): 
		if velocity.y>0: 
			change_state(State.FALLING)
		else:
			change_state(State.JUMP)
		return 
		
	
		
	if abs(facing_direction) > 0:
		change_state(State.RUNNING)
	else:
		change_state(State.IDLE)
		
		
func print_state(): 
	match current_state: 
		State.IDLE: print("idle")
		State.ATTACK: print("attack")
		State.ATTACK2: print("attack2")
		State.JUMP: print("jump")
		State.FALLING: print("falling")
		State.RUNNING: print("walk")

func on_animation_finished():
	if current_state == State.ATTACK or current_state == State.ATTACK2:
		#is_attacking = false
		call_deferred("reset_attacking")
	
func reset_attacking():
	is_attacking = false
