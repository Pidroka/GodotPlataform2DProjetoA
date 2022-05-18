extends KinematicBody2D

enum {
	MOVE,
	ATTACK,
	HITTED 
}



var motion = Vector2()
var speed = 0.01
var gravity = 1
const UP = Vector2(0, -1)
var direction = 1

#var invinciblePlayer = get_node("res://Player/Detection.gd").get("invincible")
onready var animationPlayer = $AnimationPlayer
onready var rayCast2D = $RayCast2D
var state = MOVE

func _ready():
	#$skeletonSprite.flip_h == true
		
	$RayCast2D.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _physics_process(delta):
#	print(invinciblePlayer)
	motion.y += gravity 
	
	match state: 
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		HITTED: 
			pass
			
	motion = move_and_slide(motion, UP)
	
func move_state(delta):
	$HitBox/CollisionShape2D.disabled = true
	areasPositions(delta)
	$AnimationPlayer.play("Walk")
	if is_on_wall() or not $RayCast2D.is_colliding() : 
		direction = direction * -1
		$skeletonSprite.flip_h = not $skeletonSprite.flip_h
		$RayCast2D.position.x = $CollisionShape2D.shape.get_extents().x *direction
		
	
		
	motion.y += 10 
	motion.x = 35 * direction
	
	

func attack_state(delta):
	areasPositions(delta)
	motion.x = 0
	$AnimationPlayer.play("Attack")
	


	

func areasPositions(_delta):
	if direction == 1:
		$EnemyView/EnemyViewCollisionShape2D.position.x = 10.625
		#$skeletonSprite.flip_h == false
		$HitBox/CollisionShape2D.position.x = 21
	elif direction == -1:
		$HitBox/CollisionShape2D.position.x = -21
		$EnemyView/EnemyViewCollisionShape2D.position.x = -10.625
		#$skeletonSprite.flip_h == true



func _on_EnemyView_area_entered(area):
	if area.is_in_group("playerDetection"):
		state = ATTACK
	


func _on_EnemyView_area_exited(area):
	if area.is_in_group("playerDetection"):
		yield(get_tree().create_timer(0.4), "timeout")	
	else:
		yield(get_tree().create_timer(2.5), "timeout")	
		state = MOVE
		
