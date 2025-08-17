extends State 
class_name Enemy_Idle

func enter():
	print("Enter - Idle")

func exit():
	print("Exit - Idle")

func handle_event(code: String):
	super(code)
	if code == "PlayerInViewRange":
		transition.emit(self, "Enemy_chase")
	if code == "PlayerInAttackRange":
		transition.emit(self, "Enemy_attack")
