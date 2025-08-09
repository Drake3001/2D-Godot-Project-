extends CharacterBody2D

const Const = preload("res://entity/nightborne_enemy/const_nighborne.gd")

@onready var animation_player=$AnimatedSprite2D
@onready var player_detection=$PlayerDetector
@onready var movement_component=$EnemyMovement 

var current_state= Const.StateENM.IDLE
var previous_state= Const.StateENM.IDLE
var player_body=null
var facing_direction=1.0
var is_attacking=false 



func _ready():
	player_detection.player_tracking_update.connect(update_activity)
	movement_component.direction_changed.connect(update_direction)
	animation_player.animation_finished.connect(animation_finished)

func update_direction(direction):
	facing_direction = direction
	animation_player.change_direction(facing_direction)
	
func update_activity(body): 
	player_body=body
	if player_body==null:
		change_state(Const.StateENM.IDLE)
	else:
		change_state(Const.StateENM.CHASE)

func _physics_process(delta: float) -> void:
	if player_body!=null:
		var player_position= player_body.global_position
		var self_position=global_position
		update_state(player_position, self_position)
		movement_component.update_movement(player_body.global_position.x, global_position.x)
		move_and_slide()
	else:
		change_state(Const.StateENM.IDLE)

func update_state(player_pos: Vector2, self_pos: Vector2):
	if is_attacking==true: 
		return
	if abs(player_pos.x - self_pos.x)<Const.ATTACK_RANGE:
		if abs(player_pos.y-self_pos.y)<Const.MAX_HEIGHT_DIFF:
			movement_component.disable_movement()
			change_state(Const.StateENM.ATTACK)
			is_attacking=true
		else:
			change_state(Const.StateENM.IDLE)
	else:
		movement_component.enable_movement()
		change_state(Const.StateENM.RUNNING) 
		

func change_state(state: Const.StateENM):
	if state==Const.StateENM.IDLE:
		movement_component.disable_movement()
	animation_player.play_animation(state)
	previous_state=current_state 
	current_state=state

func animation_finished():
	is_attacking=false 
	
