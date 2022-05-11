extends Area2D

onready var attackSprite = $AttackSprite


func _ready():
	attackSprite.hide()


func _on_AttackSpriteArea_body_entered(body):
	if body.name == "Player":
		attackSprite.show()


func _on_AttackSpriteArea_body_exited(body):
	if body.name == "Player":
		attackSprite = queue_free()
