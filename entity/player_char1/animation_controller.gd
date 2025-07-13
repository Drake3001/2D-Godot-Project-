extends AnimatedSprite2D

enum State{
	IDLE, 
	RUNNING, 
	ATTACK,
	ATTACK2, 
	JUMP,
	FALLING, 
	DEAD
}
signal animation_complete(state)


func _ready(): 
	$timer_attack1.timeout.connect(_on_timer_attack1_timeout)
	$timer_attack2.timeout.connect(_on_timer_attack2_timeout)
	
func update_direction(direction):
	flip_h=(direction==-1)

func play_animation(state: State):
	

	match state:
		State.IDLE: play("idle")
		State.RUNNING: play("walk")
		State.JUMP: play("jump")
		State.FALLING: play("fall")
		State.ATTACK:
			play("attack")
			$timer_attack1.start()

		State.ATTACK2:
			play("attack2")
			$timer_attack2.start()
		_:
			play("idle")

func _on_timer_attack1_timeout():
	animation_complete.emit()

func _on_timer_attack2_timeout():
	animation_complete.emit()
