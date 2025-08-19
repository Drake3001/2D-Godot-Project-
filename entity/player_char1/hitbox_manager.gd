extends Node

@onready var hitbox = get_parent().get_node("Hitbox")
@onready var hitbox_shape = hitbox.get_node("CollisionShape2D")
@onready var hurtbox= get_parent().get_node("Hurtbox")
@onready var hurtbox_shape= hurtbox.get_node("CollisionShape2D")

const Const = preload("res://entity/player_char1/const_player.gd")
signal dmg_taken(dmg)

func _ready():
	disable_hitbox()
	enable_hurtbox()


# ========================
# HITBOX
# ========================
func enable_hitbox():
	hitbox.monitoring = true
	hitbox_shape.disabled = false

func disable_hitbox():
	hitbox.monitoring = false
	hitbox_shape.disabled = true
	
func set_hitboxes_for_attack(state: int, facing_dir: int):
	var data=Const.HITBOX_DATA[state]
	hitbox.position = Vector2(data["offset"].x * facing_dir, data["offset"].y)
	if hitbox_shape.shape is RectangleShape2D:
		hitbox_shape.shape.extents = data["size"] / 2
	elif hitbox_shape.shape is CapsuleShape2D:
		hitbox_shape.shape.radius = data["size"].x / 2
		hitbox_shape.shape.height = data["size"].y
	enable_hitbox()
 

# ========================
# HURTBOX
# ========================
func enable_hurtbox():
	hurtbox.monitoring = true
	hurtbox_shape.disabled = false

func disable_hurtbox():
	hurtbox.monitoring = false
	hurtbox_shape.disabled = true
