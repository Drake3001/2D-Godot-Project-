extends Area2D

@onready var shape = $CollisionShape2D
@onready var to_hit = $TimerToHit
@onready var hit_time = $TimerHitTime
var direction = 1

func _ready():
	to_hit.timeout.connect(enable_hitbox)
	hit_time.timeout.connect(disable_hitbox)
	shape.disabled = true

func activate_hitbox(player_body: CharacterBody2D):
	#set_hitbox()
	to_hit.start()
	
func enable_hitbox():
	shape.disabled = false
	hit_time.start()
	
func disable_hitbox():
	shape.disabled = true
	
func set_direction(new_direction: float):
	shape.position = Vector2(30 * new_direction, -23)
	#direction = new_direction
	
func set_hitbox():
	shape.position = Vector2(30 * direction, -23)
	
