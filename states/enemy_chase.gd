extends State 
class_name Enemy_Chase

func enter(): 
	print("wchodzę w chase")

func exit():
	print("wychodzę z chase") 

func update(delta: float)-> void:
	pass
func player_exited()->void:
	transition.emit(self, "enemy_idle")
func player_in_range()-> void: 
	transition.emit(self, "enemy_attack") 
