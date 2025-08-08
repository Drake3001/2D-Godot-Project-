
enum State{
	IDLE, 
	RUNNING, 
	ATTACK,
	ATTACK2, 
	JUMP,
	FALLING, 
	DEAD
}
enum Direction{LEFT=-1, 
RIGHT=1 }

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const ATTACKING_MS= 0.1* SPEED 
