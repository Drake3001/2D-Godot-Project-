extends State 
class_name Enemy_Chase

func enter(): 
	print("Enter - Chase")

func exit():
	print("Exit - Chase") 

func handle_event(code: String):
	super(code)
	if code == "PlayerOutOfViewRange":
		transition.emit(self, "Enemy_idle")
	if code == "PlayerInAttackRange":
		transition.emit(self, "Enemy_attack")
