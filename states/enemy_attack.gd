extends State 
class_name Enemy_Attack

func enter():
	print("Enter - Attack")

func exit():
	print("Exit - Attack")

func handle_event(code: String):
	super(code)
