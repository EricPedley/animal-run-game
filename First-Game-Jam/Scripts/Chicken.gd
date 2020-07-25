extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 300
const GRAVITY = 30
onready var player = get_node("../Bunny")
onready var box = get_node("Area2D")
onready var riddenBox = get_node("RiddenHitbox")
var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
var following = false
var ridden = false
var dismountJump = false
# Called when the node enters the scene tree for the first time.


func _physics_process(delta):
	var acceleration = 10
	var deceleration = 50
	var input_vector = Vector2.ZERO
	var jump_target_vector=Vector2.ZERO
	if not ridden and player!=null:#code for pseudo-pathfinding
		if position.distance_to(player.position)>700:
			position = player.position
		add_collision_exception_with(player)
		if not following and box.overlaps_body(player):
			player.jumpCoords=[]
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
			elif abs(player.position.x-position.x)>100:
				target=player.position
			if target!=Vector2.ZERO:
				input_vector.x = Vector2(target.x-position.x,target.y-position.y).x
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
	if dismountJump:
		dismountJump=false
		velocity.y+=300
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
#	pass

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index==BUTTON_RIGHT:
		print(ridden)
		if ridden:
			riddenBox.disabled=true
			player.position.y-=20
			player.dismountJump=true
			dismountJump=true
			player.riding="none"
		else:
			player.riding="Chicken"
			riddenBox.disabled=false
			position=player.position
		ridden=!ridden
