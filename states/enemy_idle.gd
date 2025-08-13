extends State 
class_name Enemy_Idle

func enter(): 
	print("wchodzę w idle")

func exit():
	print("wychodzę z idle") 

func handle_event(code: String): 
	if code=="PlayerInViewRange": 
		transition.emit(self, "Enemy_chase")
	if code=="PlayerInAttackRange": 
		transition.emit(self, "Enemy_attack")
