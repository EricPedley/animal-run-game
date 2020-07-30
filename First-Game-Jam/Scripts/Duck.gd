extends "Animal.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	setOffset(140)
	setSpeed(250)
	setAnimalName("Duck")

func _physics_process(delta):
	movementStuffWrapper()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
