extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ph():
	var input_vector = Vector2.ZERO
	input_vector = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	move_and_slide(input_vector)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
