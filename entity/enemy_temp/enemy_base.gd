extends CharacterBody2D
class_name Enemy

# Komponenty
@onready var movement: MovementComponentEnemy = $MovementComponent
@onready var combat: CombatHandler = $CombatHandler
@onready var state_machine: StateMachineEnemy = $StateMachine
@onready var hitbox_manager: HitboxManager = $HitboxManager
@onready var body_animation: AnimatedSprite2D = $BodyAnimation

func _ready() -> void:
	# Podpięcie sygnałów komponentów
	#movement
	#combat
	state_machine.state_changed.connect(on_state_changed)
	hitbox_manager.transition.connect(tmp_signal)
	#body_animation
	
func on_state_changed(new_state: String):
	body_animation.change_animation(new_state.substr(6, new_state.length() - 6))
	
func tmp_signal(code: String):
	state_machine.handle_event(code)
