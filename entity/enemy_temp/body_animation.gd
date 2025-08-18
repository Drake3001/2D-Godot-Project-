extends AnimatedSprite2D

func change_animation(animation_name: String):
	print(animation_name)
	play(animation_name)
func change_direction(new_direction: float):
	flip_h=(new_direction==-1)
