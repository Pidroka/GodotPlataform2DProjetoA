extends Area2D

onready var walkSprite = $WalkSprite

func _ready():
	walkSprite.hide()



func _on_WalkSpriteArea_body_entered(body):
	if body.name =="Player":
		yield(get_tree().create_timer(1.5), "timeout")	
		walkSprite.show()
		
		

func _on_WalkSpriteArea_body_exited(body):
	if body.name =="Player":
		walkSprite = queue_free()
		
