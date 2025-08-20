extends Node2D
class_name HitboxManager

signal hitbox_mgr_update(code: String, body: Variant , dmg: Variant)
@onready var view_range = $ViewRange
@onready var attack_range = $AttackRange
@onready var hurtbox = $Hurtbox
@onready var hitbox= $Hitbox
var player_body: CharacterBody2D
var states_dict: Dictionary = {"enemy_attack": handle_attack}

func _ready():
	view_range.player_body_update.connect(on_transition)
	attack_range.player_body_update.connect(on_transition)
	hurtbox.attack_connected.connect(on_transition)
	
	
func on_transition(code: String, body: Variant=null , dmg: Variant = null):
	player_body=body 
	hitbox_mgr_update.emit(code, body, dmg)

func handle_new_state(state: String):
	if state.to_lower() in states_dict:
		states_dict[state.to_lower()].call()
func handle_attack(): 
	hitbox.activate_hitbox(player_body)
