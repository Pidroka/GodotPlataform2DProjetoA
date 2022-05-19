extends Node2D
 
onready var transition = get_node("Transition/Fill")
onready var animation = get_node("Transition/Fill/animation")
onready var player = get_node("Player").get("restartTranstion")


export(int,"Pixels,","Spot Player","Spot Center","Vetical","Horizontal") var transition_type
export(float,2.0) var duration = 1.0



func _enter_tree():
	if Checkpoint.last_position:
		$Player.global_position = Checkpoint.last_position
	
	if player == true:
		animation.play("transition_out")
	
func _ready():
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
	

	
