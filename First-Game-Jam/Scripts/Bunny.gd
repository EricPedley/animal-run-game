extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 250
const GRAVITY = 30
onready var ray = $RayCast2D
var velocity = Vector2.ZERO
var respawn_point = Vector2(100, 393)
var jumpCoords = []

var equip
var hasEquip = false


var dismountJump = false
var riding = "none"
var input_vector
onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	ray.add_exception(get_node("../TileMap"))


func _physics_process(_delta):
		
	input_vector = Vector2.ZERO
	input_vector.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	if input_vector.x<0:
		sprite.flip_h=false
	elif input_vector.x>0:
		sprite.flip_h=true
	if riding!="none":
		var animal = get_node("../"+riding)
		position = animal.position+Vector2(0,-20)
		sprite.play("Idle")
		return
	velocity.x=velocity.move_toward(input_vector*SPEED,100).x
	velocity.y+=GRAVITY
	if not sprite==null:
		if is_on_floor() || (ray.is_colliding() == true && "Box" in ray.get_collider().name):
			
			if velocity.x<0:
				sprite.play("Run")
			elif velocity.x>0:
				sprite.play("Run")
			else:
				sprite.play("Idle")
				
			velocity.y=1
			if Input.is_action_just_pressed("space"):
				velocity.y=-500
				position.y-=5
				jumpCoords.append([position,velocity])
				
		else:
			if velocity.y<0:
				sprite.play("Jump")
			else:
				sprite.play("Fall")
				
	if dismountJump:
		velocity.y-=400
		dismountJump=false
	var snap = Vector2.DOWN * 32 if velocity.y>=0 else Vector2.UP
	velocity = move_and_slide_with_snap(velocity,snap,Vector2.UP)
	if position.y > 600 :
		respawn()
	
	

		
		
	
	

func _input(event):
	if event is InputEventMouseButton && event.is_pressed() && event.button_index:
		if hasEquip:
			equip.fire = true;
			equip.fire_direction = event.position
			equip.collision.set_disabled(false)
			ray.remove_exception(equip)
			equip.equiped = false
			hasEquip = false
			equip.gravity_scale = 1
			
			


func respawn():
	position = respawn_point
	
func set_respawn(respawn):
	respawn_point = respawn
	
func has_equip():
	return hasEquip

func equip(item):
	ray.add_exception(item)
	equip = item
	equip.gravity_scale = 0
	hasEquip = true
	equip.collision.set_disabled(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
