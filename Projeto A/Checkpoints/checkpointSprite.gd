extends Area2D




func _on_Checkpoint_body_entered(_body):
	Checkpoint.last_position = global_position
