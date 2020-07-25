extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 300
var velocity = Vector2.ZERO
onready var sprite = $Sprite
# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	if velocity.x<0:
		sprite.flip_h=false;
	elif velocity.x>0:
		sprite.flip_h=true
	velocity.x=velocity.move_toward(input_vector*SPEED,100).x
	if not sprite==null:
		if is_on_floor():
			if velocity.x<0:
				sprite.play("Run")
			elif velocity.x>0:
				sprite.play("Run")
			else:
				sprite.play("Idle")
		else:
			if velocity.y<0:
				sprite.play("Jump")
			else:
				sprite.play("Fall")
	velocity.y+=20
	if is_on_floor() and Input.is_action_pressed("space"):
		velocity.y=-500
	velocity = move_and_slide(velocity,Vector2.UP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
