extends "Animal.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dismountJump = false
# Called when the node enters the scene tree for the first time.
func _ready():
	setOffset(120)
	setSpeed(200)
	setAnimalName("Mushroom")

func _physics_process(delta):
	movementStuffWrapper()
	if dismountJump:
		print("dismount jumping")
		dismountJump=false
		velocity.y+=300
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func unMount():
	riddenBox.disabled=true
	player.position.y-=20
	player.riding="none"
	ridden=false
	dismountJump=true
	player.dismountJump=true
	
