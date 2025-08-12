# Enemy.gd
extends CharacterBody2D
class_name Enemy

@export var max_health: int = 100
var current_health: int

# Referencje do komponentów
@onready var movement: MovementComponentEnemy = $MovementComponent
#@onready var combat: CombatHandler = $CombatHandler
@onready var state_machine: StateMachineEnemy = $StateMachine
#@onready var hitbox_manager: HitboxManager = $HitboxManager
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	current_health = max_health

	# Podpinamy sygnały komponentów
	#movement.moved.connect(_on_moved)
	#combat.attacked.connect(_on_attacked)
	#hitbox_manager.hit.connect(_on_hit)
	#state_machine.state_changed.connect(_on_state_changed)

	# Inicjalizacja komponentów (dependency injection)
	#movement.init(self)
	#combat.init(self)
	#hitbox_manager.init(self)
	#state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine._process(delta)

# ===== Handlery sygnałów =====

func _on_moved(new_position: Vector2) -> void:
	anim_player.play("walk")

func _on_attacked(target: Node) -> void:
	anim_player.play("attack")

func _on_hit(damage: int, source: Node) -> void:
	take_damage(damage)

func _on_state_changed(new_state: String) -> void:
	anim_player.play(new_state)

# ===== Logika wspólna przeciwnika =====

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		die()

func die() -> void:
	anim_player.play("death")
	queue_free()
