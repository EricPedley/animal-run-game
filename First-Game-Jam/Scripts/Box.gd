extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = get_node("../Bunny")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


   

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RigidBody2D_input_event(viewport, event, shape_idx):
	print(event)
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_LEFT:
			if(!player.has_equip()):
				player.equip(self)


