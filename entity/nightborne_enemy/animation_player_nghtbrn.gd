extends AnimatedSprite2D
const Const = preload("res://entity/nightborne_enemy/const_nighborne.gd")


signal animation_complete 

func _ready(): 
	$attack_timer.timeout.connect(_on_timer_attack_timeout)

func play_animation(state: Const.StateENM): 
	match state: 
		Const.StateENM.IDLE: play("idle")
		Const.StateENM.RUNNING: play("walk")
		Const.StateENM.ATTACK: 
			play("attack")
			$attack_timer.start()
		Const.StateENM.DEAD: play("death")
		Const.StateENM.TAKE_DMG: play("take_dmg")
		
func change_direction(direction):
	flip_h=(direction==-1)

func _on_timer_attack_timeout():
	animation_complete.emit()
