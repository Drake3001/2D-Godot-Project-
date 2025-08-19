extends Node2D
class_name HitboxManager

signal hitbox_mgr_update(code: String, body: Variant , dmg: Variant)
@onready var view_range = $ViewRange
@onready var attack_range = $AttackRange
@onready var hurtbox = $Hurtbox

func _ready():
	view_range.player_body_update.connect(on_transition)
	attack_range.player_body_update.connect(on_transition)
	hurtbox.attack_connected.connect(on_transition)
	
	
func on_transition(code: String, body: Variant=null , dmg: Variant = null):
	hitbox_mgr_update.emit(code, body, dmg)
	
