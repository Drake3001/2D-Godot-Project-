extends CharacterBody2D
class_name Enemy



# Komponenty
@onready var movement: MovementComponentEnemy = $MovementComponent
@onready var combat_handler: CombatHandler = $CombatHandler
@onready var state_machine: StateMachineEnemy = $StateMachine
@onready var hitbox_manager: HitboxManager = $HitboxManager
@onready var body_animation: AnimatedSprite2D = $BodyAnimation

func _ready() -> void:
	# Podpięcie sygnałów komponentów
	#movement
	combat_handler.combat_signal.connect(combat_handler_update)
	state_machine.state_changed.connect(on_state_changed)
	hitbox_manager.hitbox_mgr_update.connect(hitbox_manager_update)
	movement.direction_changed.connect(change_direction)
	state_machine.initialize()
	#body_animation
	
func on_state_changed(new_state: String):
	body_animation.change_animation(new_state.substr(6, new_state.length() - 6))
	movement.handle_new_state(new_state)
	hitbox_manager.handle_new_state(new_state)
	combat_handler.handle_new_state(new_state)
	
func combat_handler_update(code: String):
	state_machine.handle_event(code)
	
func hitbox_manager_update(code: String, body: Variant, dmg: Variant ):
	state_machine.handle_event(code)
	if body!=null: 
		movement.update_player_body(body)
	#if dmg: 
		#combat.handle_smth()

func change_direction(new_direction:float):
	hitbox_manager.change_direction(new_direction)
	body_animation.change_direction(new_direction)
