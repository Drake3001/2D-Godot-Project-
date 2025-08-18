extends Node2D
class_name HitboxManager

signal hitbox_mgr_update(code: String, body: CharacterBody2D)

@onready var view_range = $ViewRange
@onready var attack_range = $AttackRange

func _ready():
	view_range.player_body_update.connect(on_transition)
	# attack_range.transition.connect(on_transition)
	
func on_transition(code: String, body: CharacterBody2D):
	hitbox_mgr_update.emit(code, body)
