extends CharacterBody2D


enum State{
	IDLE, 
	RUNNING, 
	ATTACK,
	DEAD, 
	TAKE_DMG
}

@onready var animation_player=$AnimatedSprite2D

func _ready(): 
	animation_player.play_animation(State.ATTACK)
