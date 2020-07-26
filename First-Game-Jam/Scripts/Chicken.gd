extends "Animal.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var sprite = $AnimatedSprite
# Called when the node enters the scene tree for the first time.
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
		
	if ridden:
		acceleration=100
		deceleration=100
	if input_vector!=Vector2.ZERO:
		velocity.x=velocity.move_toward(input_vector*SPEED,acceleration).x
	elif is_on_floor():
		velocity.x=velocity.move_toward(Vector2.ZERO,deceleration).x
	velocity.y+=GRAVITY
	if ridden and Input.is_action_pressed("space") and velocity.y>0:
		velocity.y-=GRAVITY/2
		velocity.y = min(velocity.y,90)
	if is_on_floor() and is_on_wall():
		velocity.y=-300
	if not sprite==null:
		if velocity.x<0:
			sprite.flip_h=false
			sprite.play("Run")
		elif velocity.x>0:
			sprite.flip_h=true
			sprite.play("Run")
		else:
			sprite.play("Idle")
	if jump_target_vector!=Vector2.ZERO:
		velocity=jump_target_vector
	if Input.is_action_just_pressed("space") and ridden and is_on_floor():
		velocity.y= -600
	velocity=move_and_slide(velocity,Vector2.UP)
	if position.y > 600:
		if ridden:
			position = player.respawn_point
		else:
			position=player.position
		velocity=Vector2.ZERO
		player.jumpCoords=[]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	
	
		

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==BUTTON_RIGHT:
		if following and not ridden and not about_to_unmount:
			mount("Chicken")
