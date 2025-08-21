extends Node
class_name CombatHandler

signal combat_signal(code)

const HP = 30
var current_hp

func _ready():
	current_hp = HP
	
func take_dmg(dmg):
	current_hp -= dmg
	if not check_if_alive():
		combat_signal.emit("Die")
	
func check_if_alive():
	return current_hp > 0
	
func handle_new_state(new_state: String):
	if new_state == "Enemy_hurt":
		take_dmg(10)
