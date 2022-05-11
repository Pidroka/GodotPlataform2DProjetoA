extends Area2D


onready var dashSprite = $DashSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	dashSprite.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DashSpriteArea_body_entered(body):
	if body.name == "Player":
		dashSprite.show()

func _on_DashSpriteArea_body_exited(body):
	if body.name == "Player":
		dashSprite = queue_free()

