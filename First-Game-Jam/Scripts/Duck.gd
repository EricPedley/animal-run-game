extends "Animal.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	setOffset(140)
	setSpeed(250)

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	var jump_target_vector=Vector2.ZERO
	if not ridden and player!=null:#code for pseudo-pathfinding
		var vectors = move_to_player(input_vector,jump_target_vector)
		input_vector=vectors[0]
		jump_target_vector=vectors[1]
	else:
		input_vector=player.input_vector
	handle_movement(input_vector,jump_target_vector)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==BUTTON_RIGHT:
		if following and not ridden and not about_to_unmount:
			mount("Duck")
