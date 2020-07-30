extends "Animal.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	setAnimalName("Chicken")
	
func _physics_process(_delta):
	movementStuffWrapper()
	if ridden and Input.is_action_pressed("space") and velocity.y>0:
		velocity.y-=GRAVITY/2
		velocity.y = min(velocity.y,90)
