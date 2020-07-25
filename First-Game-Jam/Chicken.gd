extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 350
onready var player = get_node("../Bunny")
var velocity = Vector2.ZERO
onready var sprite = $AnimatedSprite
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	if player!=null:
		add_collision_exception_with(player)
		if abs(player.position.x-position.x)>100:
			input_vector = Vector2(player.position.x-position.x,player.position.y-position.y)
	if input_vector!=Vector2.ZERO:
		velocity.x=velocity.move_toward(input_vector*SPEED,10).x
	else:
		velocity.x=velocity.move_toward(Vector2.ZERO,50).x
	velocity.y+=20
	if(is_on_wall()):
		velocity.y=-500
	if not sprite==null:
		if velocity.x<0:
			sprite.flip_h=false
			sprite.play("Run")
		elif velocity.x>0:
			sprite.flip_h=true
			sprite.play("Run")
		else:
			sprite.play("Idle")
	velocity=move_and_slide(velocity,Vector2.UP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
