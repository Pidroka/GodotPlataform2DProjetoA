extends Area2D

onready var wallJumpSprite = $WallJumpSprite

func _on_WallJumpSpriteArea_body_entered(_body):
	wallJumpSprite.show()


func _on_WallJumpSpriteArea_body_exited(_body):
	wallJumpSprite = queue_free()
