extends State 
class_name Enemy_Hurt

func enter(): 
	print("Enter - hurt")
	take_dmg.start()

func exit():
	print("Exit - Hurt")
	take_dmg.stop() 

var last_code=""
@onready var take_dmg= $TakeDmg_timer
var dmg_locked : bool

func _ready(): 
	take_dmg.timeout.connect(handle_hurt_finished)


func handle_event(code: String):
	super(code)
	if dmg_locked:
		last_code=code
	else: 
		if code == "PlayerOutOfViewRange":
			transition.emit(self, "Enemy_idle")
		if code == "PlayerOutOfAttackRange": 
			transition.emit(self, "Enemy_chase")
			
func handle_hurt_finished():
	if last_code!="":
		handle_event(last_code)
	else: 
		return_to_previous()
