extends KinematicBody2D

enum {
	MOVE, 
	DASH, 
	ATTACK,
	DEATH
}

var motion = Vector2()
var speed = 100
var jump = -400 
var gravity = 15 
var health = 1
var actualDamage = 1 
var nextLevel
const UP = Vector2(0, -1)


var restart
var restartTranstion = false

var jumpNumber = 0
var wallJump = 150
var jumpWall = 60

#DASH VARIABLES
var dashSpeed = 350
var dashDirection = Vector2(1,0)
var canDash = false
var dashing = false
var canWalk = true


onready var animationPlayer = $AnimationPlayer
onready var playerSprite = $PlayerSprite
onready var playerColission = $Colission
onready var playerAttackBoxCollision = $PlayerAttackBox/PlayerAttackBox
onready var playerAttackBoxCollisionPosition = $PlayerAttackBox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var reviveLabel = $Revive

# Initial state 
var state = MOVE 
func _ready():
	restartTranstion = false
	reviveLabel.visible = false

func _physics_process(delta):
	
	motion.y += gravity 
	
	match state: 
		MOVE:
			move_state(delta)
		DASH: 
			dash_state(delta)
		ATTACK:
			attack_state(delta)
		DEATH: 
			death_state(delta)
	motion = move_and_slide(motion, UP)
	
func move_state(_delta):
	playerAttackBoxCollision.disabled = true
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
		playerSprite.flip_h = false
	
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
		playerSprite.flip_h = true
		
	else:
		motion.x = 0 
	
	if Input.is_action_pressed("attack"):
			attackBoxPosition()
			state = ATTACK
		
	#ANIMATIONS 	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		animationPlayer.play("Run")
	else: 
		animationPlayer.play("Idle")
		

	#JUMP STATMENTS 
	if is_on_floor() or nextToWall():
		canDash = true
		
		if Input.is_action_just_pressed("dash"):
			state = DASH
		if Input.is_action_just_pressed("ui_up") and jumpNumber > 0:
			#motion.y = jump
			jumpNumber -= 1
			motion.y = jump
			
			if not is_on_floor() and nextToRightWall() and jumpNumber > 0:
				motion.x -= wallJump
				motion.y -= jumpWall
				
			if not is_on_floor() and nextToLeftWall() and jumpNumber > 0:

				motion.x += wallJump
				motion.y -= jumpWall
		
		if nextToWall() and (motion.y > 0 or motion.y < 0): 
			animationPlayer.play("WallSlide")
			#motion.y = 100
			
		if nextToRightWall():
			playerSprite.flip_h = true

		if nextToLeftWall(): 
			playerSprite.flip_h = false
				
		
	if is_on_floor():
		jumpNumber = 2
			
	if is_on_floor() == false and not nextToRightWall() and not nextToLeftWall(): 
		
		if Input.is_action_just_pressed("dash") and canDash == true:
			canDash = true 
			state = DASH

		if motion.y < 0: 
			animationPlayer.play("Jump")
		else:
			animationPlayer.play("Falling")
	
	if Input.is_action_just_pressed("ui_down"):
			motion.y += 250
	
	

func dash_state(_delta): 
	animationPlayer.play("Dash")
	
	if playerSprite.flip_h == false: 
		dashDirection =Vector2(1,0)
		
	if playerSprite.flip_h == true:
		dashDirection =Vector2(-1,0)
	
	motion = dashDirection.normalized() * dashSpeed
	canDash = false
	dashing = true

	yield(get_tree().create_timer(0.35), "timeout")	
	dashing = false
	state = MOVE
	
func attack_state(_delta):
	playerAttackBoxCollision.disabled = false
	animationPlayer.play("Attack")
	if is_on_floor():
		motion.x = 0
	yield(get_tree().create_timer(0.4), "timeout")	
	state = MOVE
	
func death_state(_delta): 
	animationPlayer.play("Death")
	if Input.is_action_just_pressed("ui_reset"):
		restartTranstion = true
		#yield(get_tree().create_timer(0.5), "timeout")	
		restart = get_tree().reload_current_scene()

func attackBoxPosition():
	if playerSprite.flip_h == false:
		playerAttackBoxCollisionPosition.position.x = 40
	else: 
		playerAttackBoxCollisionPosition.position.x = -30
	
	
func nextToWall(): 
	return nextToRightWall() or nextToLeftWall()
		
func nextToRightWall():
	return $RightWall.is_colliding()
	
func nextToLeftWall():
	return $LeftWall.is_colliding()
	
func deathmessage():
	reviveLabel.visible = true


func _on_Detection_area_entered(area):
	if area.is_in_group("EnemyAttack"):
		state = DEATH



func _on_nextLevel_area_entered(area):
	nextLevel = get_tree().change_scene("res://levelalfa-1.tscn")




func _on_nextLevel2_area_entered(area):
	nextLevel = get_tree().change_scene("res://ty4play.tscn")
