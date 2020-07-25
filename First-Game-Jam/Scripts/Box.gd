extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = get_node("../Bunny")
onready var collision = $CollisionShape2D
onready var camera = get_node("../Bunny/Camera2D")

var equiped = false
var fire = false
var fire_direction



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(state):
	
	if equiped:
		state.transform = Transform2D(0, player.position)
	elif fire:
		print(position)
		print(OS.get_window_size())
		print(fire_direction)
		state.transform = Transform2D(0, (position) + ((fire_direction - OS.get_window_size()/2)).normalized()*10)
		linear_velocity = (fire_direction - OS.get_window_size()/2)/2
		fire = false

   

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RigidBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_LEFT:
			if(!player.has_equip()):
				player.equip(self)
				equiped = true


