extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 300
var velocity = Vector2.ZERO
var respawn_point = Vector2(500, 300)
var jumpCoords = []

var equip
var hasEquip = false



var riding = false
var input_vector
onready var sprite = $Sprite
# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
		
	input_vector = Vector2.ZERO
	input_vector.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	if input_vector.x<0:
		sprite.flip_h=false
	elif input_vector.x>0:
		sprite.flip_h=true
	if riding:
		var chicken = get_node("../Chicken")
		position = chicken.position+Vector2(0,-20)
		sprite.play("Idle")
		return
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
	if is_on_floor() and Input.is_action_just_pressed("space"):
		velocity.y=-500
		jumpCoords.append([position,velocity])
	velocity = move_and_slide(velocity,Vector2.UP)
	if position.y > 600 :
		respawn()
	
	if hasEquip:
		equip.position = position
		
		
	
	

func _input(event):
	if event is InputEventMouseButton && event.is_pressed() && event.button_index:
		if hasEquip:
			equip.set_linear_velocity(( event.position - equip.position))
			hasEquip = false


func respawn():
	position = respawn_point
	
func set_respawn(respawn):
	respawn_point = respawn
	
func has_equip():
	return hasEquip

func equip(item):
	equip = item
	hasEquip = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
