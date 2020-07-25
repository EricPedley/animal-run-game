extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 350
onready var player = get_node("../Bunny")
onready var box = get_node("Area2D")
var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
var following = false
# Called when the node enters the scene tree for the first time.


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	var jump_target_vector=Vector2.ZERO
	if player!=null:
		add_collision_exception_with(player)
		if not following and box.overlaps_body(player):
			player.jumpCoords=[]
			following=true
			velocity.y=-200
		if following and abs(player.position.x-position.x)>100:
			var target = Vector2.ZERO
			if player.jumpCoords.size()>0:
				var pv=player.jumpCoords[0]#position and velocity at the point where the player jumped
				print(pv)
				target = pv[0]
				if is_on_floor() and abs(position.x-target.x)<20:
					player.jumpCoords.pop_front()
					jump_target_vector=pv[1]
			else:
				target=player.position
			input_vector.x = Vector2(target.x-position.x,target.y-position.y).x
	if input_vector!=Vector2.ZERO:
		velocity.x=velocity.move_toward(input_vector*SPEED,10).x
	else:
		velocity.x=velocity.move_toward(Vector2.ZERO,50).x
	velocity.y+=20
	#if(is_on_wall()):
		#velocity.y=-500
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
	velocity=move_and_slide(velocity,Vector2.UP)
	if(position.y > 600):
		position=player.position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
   # Mouse in viewport coordinates
   if event is InputEventMouseButton:
	   print("Mouse Click/Unclick at: ", event.position)
