extends Area2D

onready var wallJumpSprite = $WallJumpSprite

func _on_WallJumpSpriteArea_body_entered(body):
	wallJumpSprite.show()


func _on_WallJumpSpriteArea_body_exited(body):
	wallJumpSprite = queue_free()
