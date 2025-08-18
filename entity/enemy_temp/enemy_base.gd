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
	hitbox_manager.hitbox_mgr_update.connect(hitbox_manager_update)
	movement.direction_changed.connect(change_direction)
	state_machine.initialize()
	#body_animation
	
func on_state_changed(new_state: String):
	print("ustawiam state na idle")
	body_animation.change_animation(new_state.substr(6, new_state.length() - 6))
	movement.handle_new_state(new_state)
	
func hitbox_manager_update(code: String, body: CharacterBody2D):
	state_machine.handle_event(code)
	movement.update_player_body(body)

func change_direction(new_direction:float): 
	body_animation.change_direction(new_direction)
