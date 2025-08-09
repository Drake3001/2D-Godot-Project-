
enum State{
	IDLE, 
	RUNNING, 
	ATTACK,
	ATTACK2, 
	JUMP,
	FALLING, 
	DEAD, 
	TAKING_DMG,
}
enum Direction{LEFT=-1, 
RIGHT=1 }

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const ATTACKING_MS= 0.1* SPEED

const HITBOX_DATA = {
	1: {
		"offset": Vector2(30, 0),
		"size": Vector2(40, 20)
	},
	2: {
		"offset": Vector2(50, -5),
		"size": Vector2(60, 25)
	}
}
