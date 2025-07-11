extends AnimatedSprite2D
enum State{
	IDLE, 
	RUNNING, 
	ATTACK,
	DEAD, 
	TAKE_DMG
}

func play_animation(state:State): 
	match state: 
		State.IDLE: play("idle")
		State.RUNNING: play("walk")
		State.ATTACK: play("attack")
		State.DEAD: play("death")
		State.TAKE_DMG: play("take_dmg")
