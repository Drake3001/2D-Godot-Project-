extends Area2D


# Called when the node enters the scene tree for the first time.
signal attack_connected(code: String, body: Variant, dmg : Variant )
func _ready() -> void:
	pass # Replace with function body.

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_Attack"):
		attack_connected.emit("TakeDmg",null ,1.0) #tu dodać value do dmg 
