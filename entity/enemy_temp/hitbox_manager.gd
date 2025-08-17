extends Node2D
class_name HitboxManager

signal transition(code: String)

@onready var view_range = $ViewRange
@onready var attack_range = $AttackRange

func _ready():
	view_range.transition.connect(on_transition)
	# attack_range.transition.connect(on_transition)
	
func on_transition(code: String):
	transition.emit(code)
