extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SPEED = 300
const GRAVITY = 30
onready var player = get_node("../Bunny")
onready var cage = get_node("Area2D")
onready var riddenBox = get_node("RiddenHitbox")
var velocity = Vector2.ZERO
var following = false
var ridden = false
var freed = false
var offset = 100
var about_to_unmount=false
var animalName = ""
func setAnimalName(newName):
	animalName=newName
	print(newName)
	#connect("input_event",self,"_on_Animal_input_event")
onready var sprite = $AnimatedSprite
# Called when the node enters the scene tree for the first time.
func movementStuffWrapper():
	about_to_unmount=false
	var input_vector = Vector2.ZERO
	var jump_target_vector=Vector2.ZERO
	if not ridden and player!=null:#code for pseudo-pathfinding
		var vectors = move_to_player(input_vector,jump_target_vector)
		input_vector=vectors[0]
		jump_target_vector=vectors[1]
	else:
		input_vector=player.input_vector
	handle_movement(input_vector,jump_target_vector)



func move_to_player(input_vector,jump_target_vector):
	if freed and position.distance_to(player.position)>700:
		respawn()
	add_collision_exception_with(player)
	if not freed and cage.overlaps_body(player):
		$AnimationPlayer.play("Following")
		player.jumpCoords=[]
		freed=true
		following=true
		velocity.y=-200
	if following:
		var target = Vector2.ZERO
		if player.jumpCoords.size()>0:
			var pv=player.jumpCoords[0]#position and velocity at the point where the player jumped
			target = pv[0]
			if is_on_floor() and abs(position.x-target.x)<20:
				player.jumpCoords.pop_front()
				jump_target_vector=pv[1]
		elif abs(player.position.x-position.x)>offset:
			target=player.position
		if target!=Vector2.ZERO:
			input_vector.x = Vector2(target.x-position.x,target.y-position.y).x
	return [input_vector,jump_target_vector]
	
func handle_movement(input_vector,jump_target_vector):
	var acceleration = 10
	var deceleration = 50
	if ridden:
		acceleration=100
		deceleration=100
	if input_vector!=Vector2.ZERO:
		velocity.x=velocity.move_toward(input_vector*SPEED,acceleration).x
	elif velocity.y>=0:
		velocity.x=velocity.move_toward(Vector2.ZERO,deceleration).x
	if is_on_floor() :
		if is_on_wall():
			jump(300)
	else:
		velocity.y+=GRAVITY
		
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
		jump(600)
	var snap = Vector2.DOWN * 32 if velocity.y>=0 else Vector2.UP
	velocity=move_and_slide_with_snap(velocity,snap,Vector2.UP)
	if position.y > 600:
		respawn()
		
func respawn():
	$AnimationPlayer.play("NotFollowing")
	following=false
	position = player.respawn_point
	position.y-=50
	position.x+=rand_range(-100,100)
	velocity=Vector2.ZERO
	player.jumpCoords=[]
	
func setOffset(newOffset):
	offset=newOffset
	
func setSpeed(newSpeed):
	SPEED=newSpeed
	
func jump(speed):
	position.y-=5
	velocity.y-=speed
	
func mount(name):
	player.riding=name
	riddenBox.disabled=false
	position=player.position
	ridden=true
	
func unMount():
	player.riding="none"
	riddenBox.disabled=true
	player.position.y-=20
	ridden=false
	
func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==BUTTON_RIGHT:
		if ridden:
			about_to_unmount=true
			unMount()
			
func handleInput(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index==BUTTON_LEFT:
			following=!following
			if following:
				$AnimationPlayer.play("Following")
			else:
				$AnimationPlayer.play("NotFollowing")
		elif event.button_index==BUTTON_RIGHT:
			if freed and not ridden and not about_to_unmount:
				mount(animalName)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Animal_input_event(_viewport, event, _shape_idx):
	print("Hhey!")
	handleInput(event)
