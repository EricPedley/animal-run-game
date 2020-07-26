extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



	


func _input_event(viewport, event, shape_idx):
	print("hi")
	if event is InputEventMouseButton:
		if event.is_pressed() && event.button_index == BUTTON_LEFT:
			get_tree().change_scene("res://Scenes/World.tscn")
	pass # Replace with function body.


func _on_Start_mouse_entered():
	print("hi")
	pass # Replace with function body.
