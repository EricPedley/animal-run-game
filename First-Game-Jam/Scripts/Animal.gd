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
var following = false
var ridden = false
var offset = 100
# Called when the node enters the scene tree for the first time.
func move_to_player(input_vector,jump_target_vector):
	if following and position.distance_to(player.position)>700:
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
		elif abs(player.position.x-position.x)>offset:
			target=player.position
		if target!=Vector2.ZERO:
			input_vector.x = Vector2(target.x-position.x,target.y-position.y).x
	return [input_vector,jump_target_vector]
func setOffset(newOffset):
	offset=newOffset

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
