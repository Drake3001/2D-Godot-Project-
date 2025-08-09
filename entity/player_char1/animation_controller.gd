extends AnimatedSprite2D

signal animation_complete(state)
signal end_invull
const Const = preload("res://entity/player_char1/const_player.gd")


func _ready():
	$timer_attack1.timeout.connect(_on_timer_attack1_timeout)
	$timer_attack2.timeout.connect(_on_timer_attack2_timeout)
	$timer_take_dmg.timeout.connect(_on_timer_take_dmg_timeout)
	$timer_invull.timeout.connect(_on_timer_invull_timeout)
	print("Połączenia dmg timer:", $timer_take_dmg.timeout.get_connections().size())
	print("Połączenia invull timer:", $timer_invull.timeout.get_connections().size())
	
func update_direction(direction):
	flip_h=(direction==-1)

func play_animation(state: Const.State):
	match state:
		Const.State.IDLE: play("idle")
		Const.State.RUNNING: play("walk")
		Const.State.JUMP: play("jump")
		Const.State.FALLING: play("fall")
		Const.State.ATTACK:
			play("attack")
			$timer_attack1.start()
		Const.State.ATTACK2:
			play("attack2")
			$timer_attack2.start()
		Const.State.TAKING_DMG:
			print("siema puszczam animacje i odpalam timery")
			$timer_take_dmg.start()
			$timer_invull.start()
			play("dmg_taken")
		_:
			play("idle")

func _on_timer_attack1_timeout():
	print("skonczyl sie timer animacji attack1") 
	animation_complete.emit()

func _on_timer_attack2_timeout():
	print("skonczyl sie timer animacji attack2 ") 
	animation_complete.emit()
func _on_timer_take_dmg_timeout():
	print("skonczyl sie timer animacji") 
	animation_complete.emit()
func _on_timer_invull_timeout():
	print("skonczyl sie timer nieśmiertelności") 
	end_invull.emit()
