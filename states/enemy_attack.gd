extends State 
class_name Enemy_Attack

var last_code=""
@onready var attack_timer= $Attack_timer
var attack_locked: bool
func _ready(): 
	attack_timer.timeout.connect(handle_attack_finish)

func enter():
	print("Enter - Attack")
	last_code=""
	attack_locked=true
	attack_timer.start()

func exit():
	attack_timer.stop()
	print("Exit - Attack")

func handle_event(code: String):
	super(code)
	if attack_locked:
		last_code=code
	else: 
		if code == "PlayerOutOfViewRange":
			transition.emit(self, "Enemy_idle")
		if code == "PlayerOutOfAttackRange": 
			transition.emit(self, "Enemy_chase")
			
func handle_attack_finish():
	if last_code!="":
		attack_locked=false 
		handle_event(last_code)
	else:
		attack_timer.start() 
