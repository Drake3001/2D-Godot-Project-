extends State 
class_name Enemy_Idle

func enter(): 
	print("wchodzę w idle")

func exit():
	print("wychodzę z idle") 

func update(delta: float)-> void:
	transition.emit(self, "Enemy_walk")
