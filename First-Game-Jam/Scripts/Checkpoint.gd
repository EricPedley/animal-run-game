extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var hitbox = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for collision in hitbox.get_overlapping_bodies ( ):
		if(collision.name == "Bunny"):
			collision.set_respawn(position)
			connect("animation_finished", self, "playFlag")
			play("Flag UP")
			
func playFlag():
	play("Flag")





