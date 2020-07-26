extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var cat = get_node("../Cat")
onready var player = get_node("../Bunny")
onready var cage = get_node("../Cat/Cage")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_LEFT:
			player.jumpCoords=[]
			cat.freed=true
			cage.set_visible(false)
			cat.following=true
			cat.velocity.y=-200
			cat.position = player.position
