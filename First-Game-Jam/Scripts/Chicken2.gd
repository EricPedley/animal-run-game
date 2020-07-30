extends "Animal.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	setAnimalName("Chicken2")
func _physics_process(delta):
	movementStuffWrapper()
	if ridden and Input.is_action_pressed("space") and velocity.y>0:
		velocity.y-=GRAVITY/2
		velocity.y = min(velocity.y,90)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	
	
		
