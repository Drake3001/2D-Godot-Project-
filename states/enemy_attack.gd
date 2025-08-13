extends State 
class_name Enemy_Attack

func enter(): 
	print("wchodzę w attack")

func exit():
	print("wychodzę z attack") 

func update(delta: float)-> void:
	pass

func player_out_of_bounds(): 
	transition.emit(self, "Enemy_idle")

func player_out_of_attack_range():
	transition.emit(self, "Enemy_chase")
