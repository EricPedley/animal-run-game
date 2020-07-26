extends "Animal.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dismountJump = false
# Called when the node enters the scene tree for the first time.
func _ready():
	setOffset(120)
	setSpeed(200)

func _physics_process(delta):
	var acceleration = 10
	var deceleration = 50
	var input_vector = Vector2.ZERO
	var jump_target_vector=Vector2.ZERO
	if not ridden and player!=null:#code for pseudo-pathfinding
		var vectors = move_to_player(input_vector,jump_target_vector)
		input_vector=vectors[0]
		jump_target_vector=vectors[1]
	else:
		input_vector=player.input_vector
	if dismountJump:
		print("dismount jumping")
		dismountJump=false
		velocity.y+=300
	handle_movement(input_vector,jump_target_vector)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_input_event(viewport, event, shape_idx):
	handleInput(event)
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==BUTTON_RIGHT:
		if following and not ridden and not about_to_unmount:
			mount("Mushroom")
func unMount():
	riddenBox.disabled=true
	player.position.y-=20
	player.riding="none"
	ridden=false
	dismountJump=true
	player.dismountJump=true
	
