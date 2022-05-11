extends Area2D

onready var jumpSprite = $JumpSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	jumpSprite.hide()



func _on_JumpSpriteArea_body_entered(body):
	if body.name == "Player":
		jumpSprite.show()
		


func _on_JumpSpriteArea_body_exited(body):
	if body.name == "Player":
		jumpSprite = queue_free()
